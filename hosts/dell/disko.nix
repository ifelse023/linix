{ disks ? [ "/dev/nvme0n1" ], ... }: {
  disko.devices = {
    disk = {
      vdb = {
        device = builtins.elemAt disks 0;
        type = "disk";
        content = {
          type = "table";
          format = "gpt";
          partitions = [
            {
              name = "ESP";
              type = "EF00";
              priority = 1;
              start = "1MiB";
              end = "1024MiB";
              bootable = true;
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = ["noatime"];
              };
            }
            {
              name = "home";
              start = "1024MiB";
              end = "200GiB";
              part-type = "primary";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/home";
                mountOptions = ["noatime" "commit=60"];

              };
            }
            {
              name = "nix";
              start = "200GiB";
              end = "-30G";
              part-type = "primary";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/nix";
                mountOptions = ["noatime" "commit=60"];

              };
            }
            {
              name = "swap";
              size = "100%";
              content = {
                type = "swap";
                discardPolicy = "both";
                resumeDevice = true;
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
          "size=6G"
          "mode=755"
        ];
      };
    };
  };
}
