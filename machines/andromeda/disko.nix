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
                type = "zfs";
                pool = "zroot";
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
                type = "zfs";
                pool = "zhome";
              };
            };
          };
        };
      };
    };
    zpool = {
      zroot = {
        type = "zpool";
        rootFsOptions = {
          acltype = "posixacl";
          atime = "off";
          compression = "zstd";
          mountpoint = "none";
          xattr = "sa";
        };
        options.ashift = "12";

        dataset = {
          "local" = {
            type = "zfs_fs";
            options.mountpoint = "none";
          };
          "local/nix" = {
            type = "zfs_fs";
            mountpoint = "/nix";
            options."com.sun:auto-snapshot" = "false";
          };
          "local/persistent" = {
            type = "zfs_fs";
            mountpoint = "/persistent";
            options."com.sun:auto-snapshot" = "false";
          };
        };
      };
      zhome = {
        type = "zpool";
        rootFsOptions = {
          acltype = "posixacl";
          atime = "off";
          compression = "zstd";
          mountpoint = "none";
          xattr = "sa";
        };
        options.ashift = "12";
        dataset = {
          "local" = {
            type = "zfs_fs";
            options.mountpoint = "none";
          };
          "local/home" = {
            type = "zfs_fs";
            mountpoint = "/persistent/home";
            options."com.sun:auto-snapshot" = "false";
          };
        }
      };
    };
  };

  fileSystems."/persistent".neededForBoot = true; # mark persistent volume as needed for boot
}