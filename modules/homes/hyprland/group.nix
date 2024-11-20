{ config, ... }:

let
  colors = config.modules.homes.colors;
in
{
  wayland.windowManager.hyprland.settings.group = {
    "col.border_active" = "rgba(${colors.secondaryHighlight}FF)";
    "col.border_inactive" = "rgba(${colors.secondaryLowlight}A5)";
    "col.border_locked_active" = "rgba(${colors.neutralLight}FF)";
    "col.border_locked_inactive" = "rgba(${colors.neutralDark}A5)";
  };
}
