# Idle daemon to power control system while not in use
{ ... }:

{
  services.hypridle = {
    enable = true;
    settings = {
      general =
        {
          before_sleep_cmd = "loginctl lock-session"; # lock before suspend. loginctl is from systemd which is a nixos dependency
          after_sleep_cmd = "hyprctl dispatch dpms on"; # to avoid having to press a key twice to turn on the display.
        };

      listener = [
        {
          timeout = "150"; # 2.5min.
          on-timeout = "brightnessctl -s set 10"; # set monitor backlight to dim
          on-resume = "brightnessctl -r"; # monitor backlight restore.
        }
        {
          timeout = "150"; # 2.5min.
          on-timeout = "brightnessctl -sd rgb:kbd_backlight set 0"; # turn off keyboard backlight.
          on-resume = "brightnessctl -rd rgb:kbd_backlight"; # turn on keyboard backlight.
        }
        {
          timeout = "300"; # 5min
          on-timeout = "loginctl lock-session"; # lock screen when timeout has passed
        }
        {
          timeout = "330"; # 5.5min
          on-timeout = "hyprctl dispatch dpms off"; # screen off when timeout has passed
          on-resume = "hyprctl dispatch dpms on"; # screen on when activity is detected after timeout has fired.
        }
        {
          timeout = "1800"; # 30min
          on-timeout = "systemctl suspend"; # suspend pc
        }
      ];
    };
  };

  # Hyprland integration
  wayland.windowManager.hyprland.settings.exec-once = [
    "hypridle"
  ];
}
