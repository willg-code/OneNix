{ config, ... }:

{
  home.file.".config/uwsm/env" = lib.mkIf config.wayland.windowManager.hyprland.enable {
    enable = true;
    text = ''
      export ELECTRON_OZONE_PLATFORM_HINT=auto
    '';
  };
}
