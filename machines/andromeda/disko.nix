{
  disko.devices = {
    nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = ["defaults" "size=50%" "mode=755"];
      };
    };
    disk = {
      "ssd" = {
        type = "disk";
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
                mountOptions = ["umask=0077"];
              };
            };
            "persist" = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = ["-f"]; # Override existing partition
                subvolumes = {
                  "/nix" = {
                    mountpoint = "/nix";
                  };
                  "/persist" = {
                    mountpoint = "/persist";
                  };
                };
              };
            };
          };
        };
      };
      "hdd" = {
        type = "disk";
        content = {
          type = "gpt";
          partitions = {
            "home" = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = ["-f"]; # Override existing partition
                mountpoint = "/persist/home";
              };
            };
          };
        };
      };
    };
  };

  fileSystems."/persist".neededForBoot = true; # persistence is needed to boot properly
  fileSystems."/persist/home".neededForBoot = true; # home is needed to boot properly
}
