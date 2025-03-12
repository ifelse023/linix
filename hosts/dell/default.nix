{ lib, ... }:
{
  imports = [
    ./intel.nix
    ./hardware-configuration.nix
    ./kernel.nix
    ./blacklist.nix
  ];

  services.fstrim.enable = lib.mkDefault true;
}
