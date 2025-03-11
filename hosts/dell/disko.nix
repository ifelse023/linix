{
  disko.devices = {
    disk = {
      main = {
        device = "/dev/nvme0n1";
        type = "disk";
        content = {
          type = "table";
          format = "gpt";
          partitions = [
            {
              name = "ESP";
              size = "1G";
              bootable = true;
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
              };
            }
            {
              name = "persist";
              size = "10G";
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
            }
            {
              name = "home";
              size = "200G";
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
            }

            {
              name = "nix";
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/nix";
                mountOptions = [
                  "noatime"
                  "discard"       
                  "data=writeback" 
                ];
              };
            }
          ];
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
