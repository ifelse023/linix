{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
{
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
      allowUnfree = true;
    };
  };
  nix = {

    package = pkgs.nixVersions.latest;
    registry = (lib.mapAttrs (_: flake: { inherit flake; })) (
      (lib.filterAttrs (_: lib.isType "flake")) inputs
    );

    settings = {
      sandbox = false;
      use-xdg-base-directories = true;
      flake-registry = "/etc/nix/registry.json";

      max-jobs = "auto";
      http-connections = 128;
      max-substitution-jobs = 128;
      builders-use-substitutes = lib.mkForce true;

      keep-derivations = true;
      keep-outputs = true;

      log-lines = 25;

      accept-flake-config = true;
      use-cgroups = true;

      allowed-users = [
        "root"
        "@wheel"
        "nix-builder"
        "wasd"
      ];
      trusted-users = [
        "root"
        "@wheel"
        "nix-builder"
        "wasd"
      ];

      system-features = [
        "gccarch-x86-64-v4"
        "nixos-test"
        "kvm"
        "ca-derivations"
        "recursive-nix"
        "big-parallel"
      ];

      keep-going = true;

      warn-dirty = false;

      auto-optimise-store = true;

      experimental-features = [
        "flakes"
        "ca-derivations"
        "nix-command"
        "recursive-nix"
        "cgroups"
      ];

      substituters = [
        "https://cache.nixos.org"
        "https://nixpkgs-wayland.cachix.org"
        "https://nix-community.cachix.org"
      ];

      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nixpkgs-wayland.cachix.org-1:3lwxaILxMRkVhehr5StQprHdEo4IrE8sRho9R9HOLYA="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };
  };

  environment.etc = lib.mapAttrs' (name: value: {
    name = "nix/path/${name}";
    value.source = value.flake;
  }) config.nix.registry;

  system.stateVersion = "25.11";
}
