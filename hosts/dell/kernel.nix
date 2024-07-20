{ pkgs, lib, ... }:
{
  boot = {

    swraid.enable = false;
    kernelParams = lib.mkAfter [
      "mitigations=off"
      "nopti"
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

    kernel.sysctl = {
      "dev.i915.perf_stream_paranoid" = 0;
      "kernel.nmi_watchdog" = 0;
      "kernel.unprivileged_userns_clone" = 1;
    };

    #kernelPackages = pkgs.linuxPackages_latest;
    kernelPackages = lib.mkForce pkgs.linuxPackages_cachyos-lto;

    loader = {
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = true;
    };

    binfmt.emulatedSystems = [ "aarch64-linux" ];
  };
  environment.systemPackages = [ pkgs.scx ];
  chaotic.scx = {
    enable = true;
    scheduler = "scx_rusty";
  };

}
