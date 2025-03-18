{ lib, ... }:
{
  imports = [
    ./intel.nix
    ./hardware-configuration.nix
    ./boot.nix
    ./blacklist.nix
  ];

  services.fstrim.enable = lib.mkDefault true;
}
