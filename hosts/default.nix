# hosts/default.nix
{ nixpkgs, self, ... }:
let
  inherit (self) inputs;
  system = ../system;
  hmModule = inputs.home-manager.nixosModules.home-manager;

  lib' = import ../lib;

  mkHomeManager = multiMonitor: {
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs;
      inherit self;
      inherit lib';
      multiMonitorSetup = multiMonitor;
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
      ./light
      system
      inputs.chaotic.nixosModules.default
      hmModule
      { home-manager = mkHomeManager true; }
    ];
    specialArgs = {
      inherit inputs;
    };
  };

  laptop2 = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      { networking.hostName = "levi"; }
      ./levi
      system
      inputs.chaotic.nixosModules.default
      hmModule
      { home-manager = mkHomeManager false; }
    ];
    specialArgs = {
      inherit inputs;
    };
  };
}
