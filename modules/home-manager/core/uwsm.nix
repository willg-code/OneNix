{
  config,
  lib,
  ...
}: {
  home.file.".config/uwsm/env" = lib.mkIf config.wayland.windowManager.hyprland.enable {
    enable = true;
    text = ''
      export ELECTRON_OZONE_PLATFORM_HINT=auto
      export LIBVA_DRIVER_NAME=nvidia
      export __GLX_VENDOR_LIBRARY_NAME=nvidia
    '';
  };
}
