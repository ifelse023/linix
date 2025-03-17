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
      # Swappiness: Set to 100 to treat IO cost as equal for anonymous pages and page cache
      "vm.swappiness" = 100;

      # VFS cache pressure: Lowered to 50 to reduce reclaiming of VFS cache
      "vm.vfs_cache_pressure" = 50;

      # Dirty bytes: Number of bytes at which a process starts writing out dirty data (256MB)
      "vm.dirty_bytes" = 268435456;

      # Page-cluster: Set to 0 for minimal consecutive page reads from swap
      "vm.page-cluster" = 0;

      # Dirty background bytes: Number of bytes at which background flusher starts (64MB)
      "vm.dirty_background_bytes" = 67108864;

      # Dirty writeback interval: Increased to 1500 centiseconds (15 seconds)
      "vm.dirty_writeback_centisecs" = 1500;

      # Disable NMI watchdog for performance and power savings
      "kernel.nmi_watchdog" = 0;

      # Enable unprivileged user namespaces for unprivileged containers
      "kernel.unprivileged_userns_clone" = 1;

      # Reduce kernel messages on console
      "kernel.printk" = "3 3 3 3";

      # Restrict kernel pointer access in /proc
      "kernel.kptr_restrict" = 2;

      # Disable kexec to prevent kernel replacement
      "kernel.kexec_load_disabled" = 1;

      # Increase netdev receive queue backlog to prevent packet loss
      "net.core.netdev_max_backlog" = 4096;

      # Increase file handle and inode cache size
      "fs.file-max" = 2097152;
    };

    #kernelPackages = pkgs.linuxPackages_latest;
    kernelPackages = lib.mkForce pkgs.linuxPackages_cachyos-lto;

    loader = {
      timeout = 5;
      efi.canTouchEfiVariables = true;
      systemd-boot.enable = false;
      grub = {
        enable = true;
        configurationLimit = 5;
        efiSupport = true;
        splashImage = /boot/theme/background.png;
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

    binfmt.emulatedSystems = [ "aarch64-linux" ];
  };

  services.scx.enable = true;
  services.scx.scheduler = "scx_rusty";
  services.scx.package = pkgs.scx_git.full;
}
