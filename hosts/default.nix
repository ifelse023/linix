{
  nixpkgs,
  self,
  ...
}: let
  inherit (self) inputs;
  system = ../system;
  #hw = inputs.nixos-hardware.nixosModules;
  hmModule = inputs.home-manager.nixosModules.home-manager;

  home-manager = {
    verbose = true;
    useUserPackages = true;
    useGlobalPkgs = true;
    extraSpecialArgs = {inherit inputs self;};
    users.wasd = import ../home;
  };

  overlays = [
    inputs.neovim-nightly-overlay.overlay
  ];
in {
  time.timeZone = nixpkgs.lib.mkDefault "Europe/Berlin";

  # desktop
  linix = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      {
        networking.hostName = "linix";
        nixpkgs.overlays = overlays;
      }
      ./dell
      system
      hmModule
      {inherit home-manager;}
    ];
    specialArgs = {inherit inputs;};
  };
}
