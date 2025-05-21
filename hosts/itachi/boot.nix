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
      limine = {
        enable = true;
        maxGenerations = 5;
      };
    };
  };

}
