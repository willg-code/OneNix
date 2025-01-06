{
  lib,
  hostName,
  ...
}: {
  wayland.windowManager.hyprland.settings.monitor =
    [
      ",preferred,auto,auto" # fallback monitor config that generally works
    ]
    ++ lib.optionals (hostName == "andromeda") [
      "DP-4, 2560x1440@180, 0x0, 1, bitdepth, 10, vrr, 1"
      "DP-5, 2560x1440@180, 2560x0, 1, bitdepth, 10, vrr, 1"
      "HDMI-A-2, 1920x1080@144, 1600x-1080, 1, vrr, 0"
    ];
}
