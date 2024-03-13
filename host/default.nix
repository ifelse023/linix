{lib, ...}: {
  imports = [
    ./intel.nix
    ./hardware-configuration.nix
    ./kernel.nix
    ./blacklist.nix
  ];
  time.timeZone = lib.mkDefault "Europe/Berlin";
  hardware.bluetooth = {
    enable = false;
  };
  networking.hostName = "linix";
}
