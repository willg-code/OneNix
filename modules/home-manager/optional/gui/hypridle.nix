# Idle daemon and lock dbus handler
{
  config,
  lib,
  ...
}: let
  moduleName = "hypridle";
  cfg = config.modules.home-manager.${moduleName};
in {
  options.modules.home-manager.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    services.hypridle = {
      enable = true; # idle daemon
      settings = {
        general = {
          before_sleep_cmd = "loginctl lock-session"; # lock before suspend
        };
        listener = [
          {
            timeout = "300"; # 5min
            on-timeout = "loginctl lock-session"; # lock session
          }
          # {
          #   timeout = "1800"; # 30min
          #   on-timeout = "systemctl suspend"; # suspend pc
          # }
        ];
      };
    };
  };

  # Hyprland integration
  wayland.windowManager.hyprland.settings.exec-once = [
    "systemctl --user enable --now hypridle.service" # start idle daemon
  ];
}
