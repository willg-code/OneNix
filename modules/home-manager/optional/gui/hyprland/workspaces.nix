{
  lib,
  hostName,
  ...
}: {
  wayland.windowManager.hyprland.settings.workspace =
    []
    ++ lib.optionals (hostName == "andromeda") [
      "1, default:true, monitor:DP-4"
      "2, default:true, monitor:DP-5"
      "3, default:true, monitor:HDMI-A-2"
    ];
}
