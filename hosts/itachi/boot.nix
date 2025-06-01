{ lib, ... }:
{
  boot = {
    swraid.enable = false;
    kernelParams = lib.mkAfter [
      "mitigations=off"
      "tsx=on"
      "nowatchdog"
    ];

    initrd = {
      systemd.enable = true;
      supportedFilesystems = [
        "ext4"
        "tmpfs"
        "btrfs"
        "vfat"
      ];
    };

loader = {
    systemd-boot.enable = false;
    timeout = 5;
    efi.canTouchEfiVariables = true;
    grub = {
      enable = true;
      efiSupport = true;
      device = "nodev";  # For UEFI systems
      configurationLimit = 5;  # Equivalent to your maxGenerations
    };
  };

  };

}
