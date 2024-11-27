# Wayland status bar
{ config, lib, ... }:

let
  moduleName = "waybar";
  cfg = config.modules.home-manager.${moduleName};
in
{
  options.modules.home-manager.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    programs.waybar.enable = true; # system taskbar

    # Hyprland integration
    wayland.windowManager.hyprland.settings.exec-once = [
      "systemctl --user enable --now waybar.service"
    ];
  };
}
