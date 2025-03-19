{
  lib,
  modulesPath,
  ...
}:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  fileSystems."/" = {
    device = "none";
    fsType = "tmpfs";
    options = [
      "size=10G"
      "mode=755"
    ];
  };

  fileSystems."/persist" = {
    neededForBoot = true;
    device = "/dev/disk/by-uuid/5957a13b-7442-4cbb-96bf-2e581fa031de";
    fsType = "btrfs";
    options = [
      "noatime"
      "subvol=persist"
      "compress=zstd:1"
    ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/5957a13b-7442-4cbb-96bf-2e581fa031de";
    fsType = "btrfs";
    options = [
      "noatime"
      "subvol=home"
      "compress=zstd:1"
    ];
  };

  fileSystems."/nix" = {
    neededForBoot = true;
    device = "/dev/disk/by-uuid/5957a13b-7442-4cbb-96bf-2e581fa031de";
    fsType = "btrfs";
    options = [
      "noatime"
      "subvol=nix"
      "compress=zstd:1"
    ];
  };

  fileSystems."/var/log" = {
    device = "/dev/disk/by-uuid/5957a13b-7442-4cbb-96bf-2e581fa031de";
    fsType = "btrfs";
    neededForBoot = true;
    options = [
      "noatime"
      "subvol=log"
      "compress=zstd:1"
    ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/C005-C73F";
    fsType = "vfat";
    options = [ "noatime" ];
  };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/aaf83dad-9431-425c-be62-8f53a7ad1288"; }
    ];

  # The priority should be a number higher than the swapfile disk-based swap devices
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    # memoryPercent = 25;
  };

  boot = {
    initrd.availableKernelModules = [
      "xhci_pci"
      "thunderbolt"
      "nvme"
      "usb_storage"
      "usbhid"
      "sd_mod"
    ];

    initrd.kernelModules = [ ];
    kernelModules = [ ];
    extraModulePackages = [ ];
  };

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
}
