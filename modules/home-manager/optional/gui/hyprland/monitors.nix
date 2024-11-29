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
      "DP-4, 1920x1080@144, 0x0, 1"
    ];
}
