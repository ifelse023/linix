{
  imports = [
    ./hardware-configuration.nix
    ./boot.nix
    ./intel.nix
  ];
  hardware.openrazer.enable = true;
}
