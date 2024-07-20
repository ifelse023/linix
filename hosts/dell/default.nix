{ lib, pkgs, ... }:
{
  imports = [
    ./intel.nix
    ./disko.nix
    ./hardware-configuration.nix
    ./kernel.nix
  ];

  services.fstrim.enable = lib.mkDefault true;
}
