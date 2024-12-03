{
  disko.devices = {
    nodev = {
      "/" ={
        fsType = "tmpfs";
        mountOptions = [ "defaults" "size=25%" "mode=755" ];
      };
    };
    disk = {
      "sdd" = {
        device = "/dev/disk/by-id/wwn-0x5f8db4c141803e8c";
        content = {
          type = "gpt";
          partitions = {
            "ESP" = {
              size = "256M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            "persistent" = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "bcachefs";
                mountpoint = "/persistent";
              };
            };
          };
        };
      };
      "hdd" = {
        device = "/dev/disk/by-id/wwn-0x50014ee20e131e19";
        content = {
          type = "gpt";
          partitions = {
            "home"= {
              size = "100%";
              content = {
                type = "filesystem";
                format = "bcachefs";
                mountpoint = "/persistent/home";
              };
            };
          };
        };
      };
    };
  };

  fileSystems."/persistent".neededForBoot = true; # mark persistent volume as needed for boot
}