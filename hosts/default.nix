{
  nixpkgs,
  self,
  ...
}:
let
  inherit (self) inputs;
  lib' = import ../lib;
  mkHomeManager = multiMonitor: hostname: {
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs;
      inherit self;
      inherit lib';
      multiMonitorSetup = multiMonitor;
      inherit hostname;
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
      ../system
      inputs.home-manager.nixosModules.home-manager
      inputs.chaotic.nixosModules.default
      { home-manager = mkHomeManager true "light"; }
    ];
    specialArgs = {
      inherit inputs;
    };
  };

  itachi = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [
      { networking.hostName = "itachi"; }
      ./itachi
      ../system
      inputs.chaotic.nixosModules.default
      inputs.home-manager.nixosModules.home-manager
      { home-manager = mkHomeManager false "itachi"; }
    ];
    specialArgs = {
      inherit inputs;
    };
  };
}
