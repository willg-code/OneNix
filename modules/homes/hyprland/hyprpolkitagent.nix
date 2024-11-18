{ pkgs, ... }:

{
  home.packages = [
    pkgs.hyprpolkitagent
  ];

  # Hyprland integration
  wayland.windowManager.hyprland.settings.exec-once = [
    "systemctl --user start hyprpolkitagent"
  ];
}
