{ pkgs, lib, ... }:
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

    kernel.sysctl = {
      "vm.swappiness" = 100;
      "vm.dirty_bytes" = 268435456;
      "vm.page-cluster" = 0;
      "vm.dirty_background_bytes" = 67108864;
      "vm.dirty_writeback_centisecs" = 1500;
      "kernel.nmi_watchdog" = 0;
      "kernel.unprivileged_userns_clone" = 1;
      "kernel.printk" = "3 3 3 3";
      "kernel.kptr_restrict" = 2;
      "kernel.kexec_load_disabled" = 1;
      "fs.file-max" = 2097152;
    };

    kernelPackages = lib.mkForce pkgs.linuxPackages_cachyos;

    loader = {
      timeout = 5;
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = false;
      grub = {
        enable = true;
        configurationLimit = 5;
        efiSupport = true;
        # splashImage = /boot/theme/background.png;
        theme = pkgs.fetchFromGitHub {
          owner = "shvchk";
          repo = "fallout-grub-theme";
          rev = "2c51d28701c03c389309e34585ca8ff2b68c23e9";
          sha256 = "05yiqm84gb6gc98s7fd6cxlmh60fn6wp7zc5n1fi3l6hzr33a1c9";
        };
        #efiInstallAsRemovable = true;
        device = "nodev";
      };
    };
  };

  services.scx = {
    enable = true;
    scheduler = "scx_rusty";
    package = pkgs.scx_git.full;
  };
}
