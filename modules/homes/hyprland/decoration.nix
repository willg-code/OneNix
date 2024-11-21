{ config, ... }:

let
  colors = config.modules.homes.colors;
in
{
  wayland.windowManager.hyprland.settings.decoration = {
    rounding = "8"; # rounded corner size
    dim_inactive = "true"; # darken the inactive windows
    dim_strength = "0.1"; # how much to darken inactives
    dim_special = "0.1"; # how much to darken screen during special workspace
    blur.passes = "3"; # smoother blur
    shadow = {
      range = "5"; # 5px shadow
      color = "rgba(${colors.neutralDark}FF)"; # set to same color as
    };
  };
}
