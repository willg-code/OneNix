{ config, ... }:

let
  colors = config.modules.home-manager.colors;
in
{
  wayland.windowManager.hyprland.settings.general = {
    border_size = "2"; # size (in pixels) of winsow border
    gaps_in = "5"; # size (in pixels) of gap between the windows
    gaps_out = "5"; # size (in pixels) of gap on the edge of the screen
    "col.active_border" = "rgba(${colors.primaryHighlight}FF)";
    "col.inactive_border" = "rgba(${colors.primaryLowlight}A5)";
    snap.enabled = true; # snap floating windows to edges
  };
}
