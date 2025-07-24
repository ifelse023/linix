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
      device = "/dev/disk/by-uuid/ef174e8b-9562-4fa6-b271-e38e5e159f16";
      fsType = "btrfs";
      options = [
        "noatime"
        "subvol=persist"
        "compress=zstd:1"
      ];
    };
    "/home" = {
      device = "/dev/disk/by-uuid/ef174e8b-9562-4fa6-b271-e38e5e159f16";
      fsType = "btrfs";
      options = [
        "noatime"
        "subvol=home"
        "compress=zstd:1"
      ];
    };
    "/nix" = {
      neededForBoot = true;
      device = "/dev/disk/by-uuid/ef174e8b-9562-4fa6-b271-e38e5e159f16";
      fsType = "btrfs";
      options = [
        "noatime"
        "subvol=nix"
        "compress=zstd:1"
      ];
    };
    "/var/log" = {
      device = "/dev/disk/by-uuid/ef174e8b-9562-4fa6-b271-e38e5e159f16";
      fsType = "btrfs";
      neededForBoot = true;
      options = [
        "noatime"
        "subvol=log"
        "compress=zstd:1"
      ];
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/1616-F333";
      fsType = "vfat";
      options = [ "noatime" ];
    };
  };
  swapDevices =
    [ { device = "/dev/disk/by-uuid/2d34360f-b0de-4aeb-bc90-9ff21887c9d5"; }
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
