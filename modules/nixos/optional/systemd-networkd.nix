# Systemd boot loader and plymouth splash screen
# DOCS: https://nixos.wiki/wiki/Grub
{
  config,
  lib,
  ...
}: let
  moduleName = "systemd-networkd";
  cfg = config.modules.nixos.${moduleName};
in {
  options.modules.nixos.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config =
    lib.mkIf cfg.enable {
    };
}
