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
in
{
  light = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      { networking.hostName = "light"; }
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
