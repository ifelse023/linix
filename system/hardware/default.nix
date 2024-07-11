{ pkgs, ... }:
{
  imports = [ ./bluetooth.nix ];

  services.fwupd = {
    enable = true;
  };

  environment.systemPackages = with pkgs; [
    lm_sensors
    sysstat
    pciutils # lspci
    usbutils # lsusb
  ];
}
