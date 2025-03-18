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
    device = "/dev/disk/by-uuid/80041144-6104-4355-8188-8c2c47f02c13";
    fsType = "btrfs";
    options = [
      "noatime"
      "subvol=persist"
      "compress=zstd:1"
    ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/80041144-6104-4355-8188-8c2c47f02c13";
    fsType = "btrfs";
    options = [
      "noatime"
      "subvol=home"
      "compress=zstd:1"
    ];
  };

  fileSystems."/nix" = {
    neededForBoot = true;
    device = "/dev/disk/by-uuid/80041144-6104-4355-8188-8c2c47f02c13";
    fsType = "btrfs";
    options = [
      "noatime"
      "subvol=nix"
      "compress=zstd:1"
    ];
  };

  fileSystems."/var/log" = {
    device = "/dev/disk/by-uuid/80041144-6104-4355-8188-8c2c47f02c13";
    fsType = "btrfs";
    neededForBoot = true;
    options = [
      "noatime"
      "subvol=log"
      "compress=zstd:1"
    ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/62B8-57BD";
    fsType = "vfat";
    options = [ "noatime" ];
  };

  swapDevices = [
    { device = "/dev/disk/by-uuid/be358932-1e80-4d53-aee0-85421349748b"; }
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
