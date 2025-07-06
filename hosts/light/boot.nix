{
  boot = {

    swraid.enable = false;
    kernelParams = [
      "mitigations=off"
      "tsx=on"
      "nowatchdog"
      "video=eDP-1:d"
      "video=HDMI-A-1:1920x1080@60"
      "video=DP-1:2560x1440@59.95"
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
      timeout = 20;
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = false;
      limine = {
        enable = true;
        maxGenerations = 5;
      };
    };
    # binfmt.emulatedSystems = [ "aarch64-linux" ];
  };

}
