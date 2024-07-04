# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, modulesPath, ... }: {
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];

  boot = {
    initrd.availableKernelModules =
      [ "xhci_pci" "thunderbolt" "nvme" "usb_storage" "usbhid" "sd_mod" ];
    initrd.kernelModules = [ ];
    kernelModules = [ "kvm-intel" ];
    extraModulePackages = [ ];
  };

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/c8475fda-8926-41d0-8a85-51e14fae6e64";
    fsType = "btrfs";
    options = [ "noatime" "discard" "subvol=root" "compress=zstd:1" ];
  };

  fileSystems."/home" = {
    device = "/dev/disk/by-uuid/c8475fda-8926-41d0-8a85-51e14fae6e64";
    fsType = "btrfs";
    options = [ "noatime" "discard" "subvol=home" "compress=zstd:1" ];
  };

  fileSystems."/nix" = {
    device = "/dev/disk/by-uuid/c8475fda-8926-41d0-8a85-51e14fae6e64";
    fsType = "btrfs";
    options = [ "noatime" "discard" "subvol=nix" "compress=zstd:1" ];
  };

  fileSystems."/persist" = {
    device = "/dev/disk/by-uuid/c8475fda-8926-41d0-8a85-51e14fae6e64";
    fsType = "btrfs";
    options = [ "noatime" "discard" "subvol=persist" "compress=zstd:1" ];
    neededForBoot = true;
  };

  fileSystems."/var/log" = {
    device = "/dev/disk/by-uuid/c8475fda-8926-41d0-8a85-51e14fae6e64";
    fsType = "btrfs";
    options = [ "noatime" "discard" "subvol=log" "compress=zstd:1" ];
    neededForBoot = true;
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/6D77-1F22";
    fsType = "vfat";
    options = [ "noatime" ];
  };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/662c0d6f-bfb6-406e-a4dd-79d6c835356e"; }
    ];


  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
