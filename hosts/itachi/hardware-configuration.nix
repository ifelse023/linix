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
      device = "/dev/disk/by-uuid/b69c1260-5a3d-4813-b0e2-1541ba183501";
      fsType = "btrfs";
      options = [
        "noatime"
        "subvol=persist"
        "compress=zstd:1"
      ];
    };
    "/home" = {
      device = "/dev/disk/by-uuid/b69c1260-5a3d-4813-b0e2-1541ba183501";
      fsType = "btrfs";
      options = [
        "noatime"
        "subvol=home"
        "compress=zstd:1"
      ];
    };
    "/nix" = {
      neededForBoot = true;
      device = "/dev/disk/by-uuid/b69c1260-5a3d-4813-b0e2-1541ba183501";
      fsType = "btrfs";
      options = [
        "noatime"
        "subvol=nix"
        "compress=zstd:1"
      ];
    };
    "/var/log" = {
      device = "/dev/disk/by-uuid/b69c1260-5a3d-4813-b0e2-1541ba183501";
      fsType = "btrfs";
      neededForBoot = true;
      options = [
        "noatime"
        "subvol=log"
        "compress=zstd:1"
      ];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/929B-368D";
      fsType = "vfat";
      options = [ "noatime" ];
    };
  };
  swapDevices =
    [ { device = "/dev/disk/by-uuid/2285ff55-1907-4803-9fef-1a50081f33be"; }
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
