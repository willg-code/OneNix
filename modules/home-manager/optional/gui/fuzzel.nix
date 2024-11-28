# Wayland app launcher
{
  config,
  lib,
  ...
}: let
  moduleName = "fuzzel";
  cfg = config.modules.home-manager.${moduleName};
in {
  options.modules.home-manager.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    programs.fuzzel.enable = true; # window switcher, app launcher, and dmenu

    # Hyprland integration
    wayland.windowManager.hyprland.settings.bind = [
      "$mainMod, D, exec, uwsm app -- fuzzel"
    ];
  };
}
