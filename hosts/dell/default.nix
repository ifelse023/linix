{ lib, ... }:
{
  imports = [
    ./intel.nix
    ./hardware-configuration.nix
    ./kernel.nix
  ];

  services.fstrim.enable = lib.mkDefault true;
}
