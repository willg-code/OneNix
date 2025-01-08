# Uses wayshot and satty to capture/annotate a wayland screen grab
{
  config,
  lib,
  pkgs,
  ...
}: let
  moduleName = "screenshot";
  cfg = config.modules.home-manager.${moduleName};
in {
  options.modules.home-manager.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.satty # screenshot annotator
      pkgs.wayshot # screenshot tool
      pkgs.slurp # region selection tool
    ];

    wayland.windowManager.hyprland.settings.bind = [
      ''$mainMod, P, exec, uwsm app -- wayshot -s "$(slurp)" --stdout | satty -f -''
    ];
  };
}
