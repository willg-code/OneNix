{ pkgs, ... }:

{
  home.packages = [
    pkgs.nordzy-cursor-theme
  ];

  # Hyprland integration
  wayland.windowManager.hyprland.settings.exec-once = [
    "hyprctl setcursor Nordzy-cursors 24"
  ];

  # XCursor/GTK integration (for apps that do not support hyprcursor)
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.nordzy-cursor-theme;
    name = "Nordzy-cursors";
    size = 24;
  };
}
