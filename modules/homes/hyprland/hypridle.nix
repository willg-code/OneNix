# Idle daemon to power control system while not in use
{ ... }:

{
  services.hypridle = {
    enable = true;
    settings = {
      general =
        {
          lock_cmd = "pidof hyprlock || hyprlock"; # what to do when the dbus lock signal is recieved
          before_sleep_cmd = "loginctl lock-session"; # lock before suspend
          after_sleep_cmd = "hyprctl dispatch dpms on"; # to avoid having to press a key a second time after wake
        };

      listener = [
        {
          timeout = "300"; # 5min
          on-timeout = "loginctl lock-session"; # lock screen when timeout has passed. loginctl is from systemd which is a nixos dependency
        }
        {
          timeout = "330"; # 5.5min
          on-timeout = "hyprctl dispatch dpms off"; # screen off when timeout has passed
          on-resume = "hyprctl dispatch dpms on"; # screen on when activity is detected
        }
        # {
        #   timeout = "1800"; # 30min
        #   on-timeout = "systemctl suspend"; # suspend pc, provided by systemd which is a nixos dependency
        # }
      ];
    };
  };

  # Hyprland integration
  wayland.windowManager.hyprland.settings.exec-once = [
    "hypridle"
  ];
}
