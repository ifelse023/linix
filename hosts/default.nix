{ nixpkgs, self, ... }:
let
  inherit (self) inputs;
  system = ../system;
  #hw = inputs.nixos-hardware.nixosModules;
  hmModule = inputs.home-manager.nixosModules.home-manager;

  home-manager = {
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {
      inherit inputs;
      inherit self;
    };
    users.wasd = {
      imports = [ ../home ];
    };
  };
  overlays = [
    # inputs.neovim-nightly-overlay.overlay
  ];
in
{
  # desktop
  linix = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      {
        networking.hostName = "linix";
        nixpkgs.overlays = overlays;
        time.timeZone = nixpkgs.lib.mkDefault "Europe/Berlin";
      }
      ./dell
      system
      inputs.chaotic.nixosModules.default
      hmModule
      { inherit home-manager; }
    ];
    specialArgs = {
      inherit inputs;
    };
  };
}
