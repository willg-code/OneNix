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
        type = "disk";
        device = "/dev/disk/by-id/ata-PNY_CS900_240GB_SSD_PNY14182241350103E8C";
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
        type = "disk";
        device = "/dev/disk/by-id/ata-WDC_WD10EZEX-60WN4A0_WD-WCC6Y0EYJS5Y";
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