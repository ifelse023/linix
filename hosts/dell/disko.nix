{
  disko.devices = {
    disk = {
      main = {
        device = "/dev/nvme0n1";
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              size = "1G";
              type = "EF00";  # EFI System Partition type
              priority = 1;
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            };
            nix = {
              size = "200G";
              priority = 2;
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/nix";
                mountOptions = [
                  "noatime"
                                  ];
              };
            };
            persist = {
              size = "50G";
              priority = 3;
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/persist";
                mountOptions = [
                  "noatime"
                  "discard"       
                  "data=writeback"
                  "commit=45"
                ];
              };
            };
            home = {
              size = "100%";
              priority = 4;
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/home";
                mountOptions = [
                  "noatime"
                  "discard"       
                  "data=writeback"
                  "commit=45"
                ];
              };
            };
          };
        };
      };
    };
    nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = [
          "defaults"
          "size=12G"
          "mode=755"
        ];
      };
    };
  };
  fileSystems."/persist".neededForBoot = true;
  # fileSystems."/nix".neededForBoot = true
  zramSwap.enable = true;
  swapDevices = [];
}
