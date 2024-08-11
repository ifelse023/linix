{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
{
  environment.systemPackages = [ pkgs.qemu ];
  documentation = {
    enable = false;
    dev.enable = true;
    doc.enable = false;
    nixos.enable = false;
    info.enable = false;
    man = {
      enable = lib.mkDefault false;
    };
  };

  nixpkgs = {
    overlays = [ inputs.nixpkgs-wayland.overlay ];
    config = {
      allowUnfree = lib.mkForce true;
      allowBroken = true;
    };
  };
  nix = {

    package = pkgs.lix;
    # Register each flake input
    registry = (lib.mapAttrs (_: flake: { inherit flake; })) (
      (lib.filterAttrs (_: lib.isType "flake")) inputs
    );

    # Specify a custom Nix path
    #nixPath = [ "/etc/nix/path" ];

    # Set Nix daemon settings
    settings = {
      sandbox = false;
      extra-platforms = [ "aarch64-linux" ];
      use-xdg-base-directories = true;
      flake-registry = "/etc/nix/registry.json";

      max-jobs = "auto";
      http-connections = 128;
      max-substitution-jobs = 128;
      builders-use-substitutes = lib.mkForce true;

      keep-derivations = true;
      keep-outputs = true;

      log-lines = 25;

      # whether to accept nix configuration from a flake without prompting
      accept-flake-config = true;
      # execute builds inside cgroups
      use-cgroups = true;

      allowed-users = [
        "root"
        "@wheel"
        "nix-builder"
        "wasd"
      ];
      # only allow sudo users to manage the nix store
      trusted-users = [
        "root"
        "@wheel"
        "nix-builder"
        "wasd"
      ];

      system-features = [
        "gccarch-x86-64-v3"
        "nixos-test"
        "kvm"
        "ca-derivations"
        "recursive-nix"
        "big-parallel"
      ];

      keep-going = true;

      # If set to true, Nix will fall back to building from source if a binary substitute
      # fails. This is equivalent to the –fallback flag. The default is false.
      #fallback = true;

      warn-dirty = false;

      # Deduplicate and optimize nix store
      auto-optimise-store = true;

      experimental-features = [
        "flakes" # flakes
        "ca-derivations"
        "nix-command" # experimental nix commands
        "recursive-nix" # let nix invoke itself
        "cgroups" # allow nix to execute builds inside cgroups
      ];

      substituters = [
        "https://cache.nixos.org"
        "https://nixpkgs-wayland.cachix.org"
        "https://nix-community.cachix.org"
        # "https://yazi.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        # "yazi.cachix.org-1:Dcdz63NZKfvUCbDGngQDAZq6kOroIrFoyO064uvLh8k="
      ];

    };
  };

  #This will add each flake input as a registry
  #To make nix3 commands consistent with your flake
  environment.etc = lib.mapAttrs' (name: value: {
    name = "nix/path/${name}";
    value.source = value.flake;
  }) config.nix.registry;

  system.stateVersion = "24.11"; # Did you read the comment?
}
