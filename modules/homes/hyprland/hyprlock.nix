{ config, pkgs, ... }:

let
  bgPath = config.modules.homes.hyprland.lockBGPath;
  colors = config.modules.homes.colors;
in
{
  home.packages = [
    pkgs.playerctl # required for scripts
  ];
  programs.hyprlock = {
    enable = true; # hyprland lock screen
    settings = {
      general =
        {
          grace = "3"; # seconds before lock actually engages
          hide_cursor = true;
        };
      background = [
        {
          monitor = ""; # all monitors
          path = if bgPath != null then (toString bgPath) else ""; # use screenshot of desktop
          color = "rgba(${colors.neutralDark}FF)"; # fallback color for no background
          blur_passes = "3"; # smooth blur
        }
      ];
      input-field = [
        # Input Box
        {
          monitor = "";
          size = "300, 60";
          outline_thickness = "2";
          dots_size = "0.1"; # Scale of input-field height, 0.2 - 0.8
          dots_spacing = "0.25"; # Scale of dots' absolute size, 0.0 - 1.0
          outer_color = "rgba(${colors.neutralDark}00)";
          inner_color = "rgba(${colors.neutralDark}A5)";
          font_color = "rgb(${colors.neutralLight})";
          check_color = "rgba(${colors.neutralLight}40)";
          font_family = "Noto Sans";
          position = "0, -100"; # offset from center of screen;
          halign = "center";
          valign = "center";
        }
      ];
      image = [
        # Music
        {
          monitor = "";
          path = "";
          size = "60"; # lesser side if not 1:1 ratio
          rounding = "5"; # negative values mean circle
          border_size = "0";
          rotate = "0"; # degrees, counter-clockwise
          reload_time = "2";
          reload_cmd = "~/.config/hypr/bin/playerctlock.sh --arturl";
          position = "-150, -300";
          halign = "center";
          valign = "center";
          opacity = "0.5";
        }
      ];
      label = [
        # Date
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(date +"%A, %B %d")"''; # get the date
          color = "rgba(${colors.neutralLight}D5)";
          font_size = "22";
          font_family = "Noto Sans";
          position = "0, 300"; # offset from center of screen
          halign = "center";
          valign = "center";
        }
        # Time
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$TIME"''; # time provided by hyprlock
          color = "rgba(${colors.neutralLight}D5)";
          font_size = "95";
          font_family = "Noto Sans";
          position = "0, 200"; # offset from center of screen
          halign = "center";
          valign = "center";
        }
        # User Greeting
        {
          monitor = "";
          text = "Hello, $DESC"; # description provided by user
          color = "rgba(${colors.neutralLight}D5)";
          font_size = "22";
          font_family = "Noto Sans";
          position = "0, 0"; # offset from center of screen
          halign = "center";
          valign = "center";
        }
        # PLAYER TITTLE
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(~/.config/hypr/bin/playerctlock.sh --title)"'';
          color = "rgba(${colors.neutralLight}D5)";
          font_size = "12";
          font_family = "JetBrains Mono Nerd Font Mono ExtraBold";
          position = "880, -290";
          halign = "left";
          valign = "center";
        }

        # PLAYER Length
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(~/.config/hypr/bin/playerctlock.sh --length) "'';
          color = "rgba(${colors.neutralLight}D5)";
          font_size = "11";
          font_family = "JetBrains Mono Nerd Font Mono";
          position = "-730, -310";
          halign = "right";
          valign = "center";
        }

        # PLAYER STATUS
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(~/.config/hypr/bin/playerctlock.sh --status)"'';
          color = "rgba(${colors.neutralLight}D5)";
          font_size = "14";
          font_family = "JetBrains Mono Nerd Font Mono";
          position = "-740, -290";
          halign = "right";
          valign = "center";
        }
        # PLAYER SOURCE
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(~/.config/hypr/bin/playerctlock.sh --source)"'';
          color = "rgba(${colors.neutralLight}D5)";
          font_size = "10";
          font_family = "JetBrains Mono Nerd Font Mono";
          position = "-740, -330";
          halign = "right";
          valign = "center";
        }

        # PLAYER ALBUM
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(~/.config/hypr/bin/playerctlock.sh --album)"'';
          color = "rgba(${colors.neutralLight}D5)";
          font_size = "10";
          font_family = "JetBrains Mono Nerd Font Mono";
          position = "880, -330";
          halign = "left";
          valign = "center";
        }
        # PLAYER Artist
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(~/.config/hypr/bin/playerctlock.sh --artist)"'';
          color = "rgba(${colors.neutralLight}D5)";
          font_size = "10";
          font_family = "JetBrains Mono Nerd Font Mono ExtraBold";
          position = "880, -310";
          halign = "left";
          valign = "center";
        }
      ];
    };
  };
}
