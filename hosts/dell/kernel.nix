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
      # The Magic SysRq key is a key combo that allows users connected to the
      # system console of a Linux kernel to perform some low-level commands.
      # Disable it, since we don't need it, and is a potential security concern.
      "kernel.sysrq" = 0;
      "vm.swappiness" = 200;
      # The value controls the tendency of the kernel to reclaim the memory which is used for caching of directory and inode objects (VFS cache).
      # Lowering it from the default value of 100 makes the kernel less inclined to reclaim VFS cache (do not set it to 0, this may produce out-of-memory conditions)
      "vm.vfs_cache_pressure" = 50;
      # Contains, as bytes, the number of pages at which a process which is
      # generating disk writes will itself start writing out dirty data.
      "vm.dirty_bytes" = 268435456;

      # page-cluster controls the number of pages up to which consecutive pages are read in from swap in a single attempt.
      # This is the swap counterpart to page cache readahead. The mentioned consecutivity is not in terms of virtual/physical addresses,
      # but consecutive on swap space - that means they were swapped out together. (Default is 3)
      # increase this value to 1 or 2 if you are using physical swap (1 if ssd, 2 if hdd)
      "vm.page-cluster" = 0;

      # Contains, as bytes, the number of pages at which the background kernel
      # flusher threads will start writing out dirty data.
      "vm.dirty_bagckground_bytes" = 67108864;

      # The kernel flusher threads will periodically wake up and write old data out to disk.  This
      # tunable expresses the interval between those wakeups, in 100'ths of a second (Default is 500).
      "vm.dirty_writeback_centisecs" = 1500;

      # Hide kptrs even for processes with CAP_SYSLOG.
      # Also prevents printing kernel pointers.
      "kernel.kptr_restrict" = 2;

      # This action will speed up your boot and shutdown, because one less module is loaded. Additionally disabling watchdog timers increases performance and lowers power consumption
      # Disable NMI watchdog
      "kernel.nmi_watchdog" = 0;

      # Enable the sysctl setting kernel.unprivileged_userns_clone to allow normal users to run unprivileged containers.
      "kernel.unprivileged_userns_clone" = 1;

      # Set size of file handles and inode cache
      "fs.file-max" = 2097152;
      "dev.i915.perf_stream_paranoid" = 0;
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
