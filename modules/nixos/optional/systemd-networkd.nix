# Systemd network manager
# DOCS: https://nixos.wiki/wiki/Systemd-networkd
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

  config = lib.mkIf cfg.enable {
    systemd.network.enable = true;
    networking.useDHCP = false; # don't use dhcpd, it conflicts with networkd
  };
}
