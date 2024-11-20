{ ... }:

{
  wayland.windowManager.hyprland.settings = {
    # These make the behavior of apps more predictable
    windowrulev2 = [
      "suppressevent maximize, class:.*" # no auto maximization
      "suppressevent fullscreen, class:.*" # no auto fullscreen
    ];
  };
}
