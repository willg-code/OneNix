{...}: {
  wayland.windowManager.hyprland.settings.xwayland = {
    force_zero_scaling = "true"; # prevents distortion on xwayland
  };
}
