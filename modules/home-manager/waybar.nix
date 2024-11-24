{ config, lib, ... }:

let
  moduleName = "waybar";
  cfg = config.modules.homes.${moduleName};
in
{
  options.modules.homes.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    programs.waybar.enable = true; # system taskbar

    # Hyprland integration
    wayland.windowManager.hyprland.settings.exec-once = [
      "waybar"
    ];
  };
}
