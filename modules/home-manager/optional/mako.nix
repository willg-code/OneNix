# Simple notification manager
{ config, lib, ... }:

let
  moduleName = "mako";
  cfg = config.modules.home-manager.${moduleName};
in
{
  options.modules.home-manager.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    services.mako.enable = true; # notification manager

    # Hyprland integration
    wayland.windowManager.hyprland.settings.exec-once = [
      "uwsm app -- mako"
    ];
  };
}
