{
  lib,
  modulesPath,
  ...
}:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  fileSystems = {
    "/" = {
      device = "none";
      fsType = "tmpfs";
      options = [
        "size=10G"
        "mode=755"
      ];
    };
    "/persist" = {
      neededForBoot = true;
      device = "/dev/disk/by-uuid/0ad37213-1252-4ec1-9548-28d496f2e5db";
      fsType = "btrfs";
      options = [
        "noatime"
        "subvol=persist"
        "compress=zstd:1"
      ];
    };
    "/home" = {
      device = "/dev/disk/by-uuid/0ad37213-1252-4ec1-9548-28d496f2e5db";
      fsType = "btrfs";
      options = [
        "noatime"
        "subvol=home"
        "compress=zstd:1"
      ];
    };
    "/nix" = {
      neededForBoot = true;
      device = "/dev/disk/by-uuid/0ad37213-1252-4ec1-9548-28d496f2e5db";
      fsType = "btrfs";
      options = [
        "noatime"
        "subvol=nix"
        "compress=zstd:1"
      ];
    };
    "/var/log" = {
      device = "/dev/disk/by-uuid/0ad37213-1252-4ec1-9548-28d496f2e5db";
      fsType = "btrfs";
      neededForBoot = true;
      options = [
        "noatime"
        "subvol=log"
        "compress=zstd:1"
      ];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/BC31-5451";
      fsType = "vfat";
      options = [ "noatime" ];
    };
  };
  swapDevices =
    [ { device = "/dev/disk/by-uuid/d26f2754-d1ec-4311-a9bf-6ef8006217ba"; }
    ];

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
