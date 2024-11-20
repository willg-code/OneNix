{ ... }:

{
  wayland.windowManager.hyprland.settings.misc = {
    disable_hyprland_logo = "true"; # disable default hyprland backgrounds
    disable_splash_rendering = "true"; # disable splash text
    focus_on_activate = "true"; # apps can request focus
    vrr = "2"; # use variable refresh rate (if available) when fullscreen
  };
}
