{ pkgs, lib, ... }: {
  boot = {
    kernelParams = lib.mkAfter [
      # Disable all mitigations
      "mitigations=off"
      "nopti"
      "tsx=on"
      # Laptops and dekstops don't need Watchdog
      "nowatchdog"
    ];

    initrd = {
      systemd.enable = true;
      supportedFilesystems = [ "ext4" "btrfs" "vfat" ];
    };

    # use latest kernel
    kernelPackages = pkgs.linuxPackages_latest;

    loader = {
      # systemd-boot on UEFI
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };
  };
}
