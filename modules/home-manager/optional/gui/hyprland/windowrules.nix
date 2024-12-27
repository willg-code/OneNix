{...}: {
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      "noblur,xwayland:1" # don't blur xwayland windows, fixes popup issue
    ];
  };
}
