{...}: {
  wayland.windowManager.hyprland.settings = {
    windowrulev2 = [
      "suppressevent maximize, class:.*" # no auto maximization
      "suppressevent fullscreen, class:.*" # no auto fullscreen
      "noblur,xwayland:1" # don't blur xwayland windows, fixes popup issue
    ];
  };
}
