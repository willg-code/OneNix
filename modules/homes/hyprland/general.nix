{ ... }:

{
  wayland.windowManager.hyprland.settings.general = {
    gaps_in = "5"; # size (in pixels) of gap between the windows
    gaps_out = "5"; # size (in pixels) of gap on the edge of the screen
    border_size = "2"; # size (in pixels) of winsow border
    "col.active_border" = "rgba(${colors.primaryHighlight}FF)";
    "col.inactive_border" = "rgba(${colors.primaryLowlight}A5)";
    snap.enabled = true; # snap floating windows to edges
  };
}
