{ lib, pkgs, ... }:
{

  boot = {

    kernelPackages = lib.mkForce pkgs.linuxPackages_cachyos;

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

    enableContainers = false;
    tmp = {
      cleanOnBoot = true;
      useTmpfs = true;
      tmpfsSize = "80%";
    };
  };

}
