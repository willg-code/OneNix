# Systemd boot loader and plymouth splash screen
# DOCS: https://nixos.wiki/wiki/Grub
{
  config,
  lib,
  ...
}: let
  moduleName = "systemd-boot";
  cfg = config.modules.nixos.${moduleName};
in {
  options.modules.nixos.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    boot.loader.systemd-boot = {
      enable = true; # enable bootloader
      editor = false; # no command line boot entry; security risk
      memtest86.enable = true; # mem test available in bootloader
      configurationLimit = 10; # max number of configuration boot entries
    };
  };

  # No persistence mounting needed because boot must be a separate vfat partition
}
