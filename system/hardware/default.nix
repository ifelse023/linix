{ pkgs, ... }: {
  imports = [ ./bluetooth.nix ./brillo.nix ];

  services.fwupd = { enable = true; };

  environment.systemPackages = with pkgs; [
    #sof-firmware
    lm_sensors
    # system tools
    sysstat
    pciutils # lspci
    usbutils # lsusb
    hdparm # for disk performance, command
    dmidecode # a tool that reads information about your system's hardware from the BIOS according to the SMBIOS/DMI standard
  ];
}
