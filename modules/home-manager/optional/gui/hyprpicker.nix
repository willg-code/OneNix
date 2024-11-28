# Wayland color picker
{
  config,
  lib,
  pkgs,
  ...
}: let
  moduleName = "hyprpickers";
  cfg = config.modules.home-manager.${moduleName};
in {
  options.modules.home-manager.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.hyprpicker # color picker for hyprland
      pkgs.wl-clipboard-rs # wl-clipboard implementation, required for hyprpicker -a
    ];
    wayland.windowManager.hyprland.settings.bind = [
      "$mainMod $shiftMod, P, exec, uwsm app -- hyprpicker -ar" # color picker
    ];
  };
}
