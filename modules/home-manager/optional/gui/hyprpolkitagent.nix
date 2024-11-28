# Wayland Polkit agent
{
  config,
  lib,
  pkgs,
  ...
}: let
  moduleName = "hyprpolkitagent";
  cfg = config.modules.home-manager.${moduleName};
in {
  options.modules.home-manager.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.hyprpolkitagent # polkit agent
    ];
    wayland.windowManager.hyprland.settings.exec-once = [
      "systemctl --user enable --now hyprpolkitagent.service" # start polkit daemon
    ];
  };
}
