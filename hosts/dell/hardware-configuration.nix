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
    device = "/dev/disk/by-uuid/e9ee02b6-3791-43ca-aafb-36a1dfa31765";
    fsType = "btrfs";
    options = [
      "noatime"
      "subvol=persist"
      "compress=zstd:1"
    ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/e9ee02b6-3791-43ca-aafb-36a1dfa31765";
    fsType = "btrfs";
    options = [
      "noatime"
      "subvol=home"
      "compress=zstd:1"
    ];
  };

  fileSystems."/nix" = {
    neededForBoot = true;
    device = "/dev/disk/by-uuid/e9ee02b6-3791-43ca-aafb-36a1dfa31765";
    fsType = "btrfs";
    options = [
      "noatime"
      "subvol=nix"
      "compress=zstd:1"
    ];
  };

  fileSystems."/var/log" = {
    device = "/dev/disk/by-uuid/e9ee02b6-3791-43ca-aafb-36a1dfa31765";
    fsType = "btrfs";
    neededForBoot = true;
    options = [
      "noatime"
      "subvol=log"
      "compress=zstd:1"
    ];
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/E8CE-3B97";
    fsType = "vfat";
    options = [ "noatime" ];
  };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/52bd5843-11a5-436f-8557-8c5cf3abc61b"; }
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
