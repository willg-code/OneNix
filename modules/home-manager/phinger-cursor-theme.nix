# Cursor theme that works for any window manager
{ config, lib, pkgs, ... }:

let
  moduleName = "phinger-cursor-theme";
  cfg = config.modules.homes.${moduleName};
in
{
  options.modules.homes.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.phinger-cursors
    ];

    # Hyprland integration
    wayland.windowManager.hyprland.settings.exec = [
      "hyprctl setcursor phinger-cursors-light 24"
    ];

    # XCursor/GTK integration (for apps that do not support hyprcursor)
    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      package = pkgs.phinger-cursors;
      name = "phinger-cursors-light";
      size = 24;
    };
  };
}
