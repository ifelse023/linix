{
  description = "nix config";
  inputs = {

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    chaotic.url = "https://flakehub.com/f/chaotic-cx/nyx/*.tar.gz";
    xremap-flake.url = "github:xremap/nix-flake";
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    impermanence.url = "github:nix-community/impermanence";

    nix-index-db = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs-wayland = {
      url = "github:nix-community/nixpkgs-wayland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
    };

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    tealdeer-git.url = "path:/home/wasd/pkgs/tealdeer";

    catppuccin.url = "github:catppuccin/nix";

  };

  outputs =
    {
      flake-parts,
      ...
    }@inputs:
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      imports = [

        ./shell.nix
        inputs.flake-parts.flakeModules.easyOverlay
      ];

      flake = {
        nixosConfigurations = import ./hosts inputs;
      };
    };
}
