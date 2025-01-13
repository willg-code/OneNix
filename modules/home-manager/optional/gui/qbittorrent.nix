# GUI bittorrent client
{
  config,
  lib,
  pkgs,
  ...
}: let
  moduleName = "qbittorrent";
  cfg = config.modules.home-manager.${moduleName};
in {
  options.modules.home-manager.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.qbittorrent-enhanced
    ];
  };
}
