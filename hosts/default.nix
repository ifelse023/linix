{ nixpkgs, self, ... }:
let
  inherit (self) inputs;
  system = ../system;
  hmModule = inputs.home-manager.nixosModules.home-manager;

  lib' = import ../lib;
  home-manager = {
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs;
      inherit self;
      inherit lib';
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
