{ config, pkgs, ... }:

let
  bgPath = config.modules.homes.hyprland.lockBGPath;
  colors = config.modules.homes.colors;
  font = "JetBrains Mono Nerd Font Mono";
  font_bold = "JetBrains Mono Nerd Font Mono ExtraBold";
  whatsong = (import ./scripts/whatsong.nix pkgs);
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
          font_family = font;
          position = "0, -30"; # offset from center of screen;
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
          reload_time = "1";
          reload_cmd = "${whatsong} --arturl";
          position = "760, 45"; # offset from center bottom
          halign = "left";
          valign = "bottom";
        }
      ];
      label = [
        # Date
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(date +"%A, %B %d")"''; # get the date
          color = "rgba(${colors.neutralLight}F0)";
          font_size = "22";
          font_family = font;
          position = "0, 280"; # offset from center of screen
          halign = "center";
          valign = "center";
        }
        # Time
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$TIME"''; # time provided by hyprlock
          color = "rgba(${colors.neutralLight}F0)";
          font_size = "95";
          font_family = font_bold;
          position = "0, 200"; # offset from center of screen
          halign = "center";
          valign = "center";
        }
        # User Greeting
        {
          monitor = "";
          text = "Hello, $DESC"; # description provided by user
          color = "rgba(${colors.neutralLight}F0)";
          font_size = "22";
          font_family = font;
          position = "0, 30"; # offset from center of screen
          halign = "center";
          valign = "center";
        }
        # Player Title
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(${whatsong} --title)"'';
          color = "rgba(${colors.neutralLight}F0)";
          font_size = "12";
          font_family = font;
          position = "860, 90";
          halign = "left";
          valign = "bottom";
        }
        # Player Length
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(${whatsong} --length) "'';
          color = "rgba(${colors.neutralLight}F0)";
          font_size = "11";
          font_family = font;
          position = "-770, 70";
          halign = "right";
          valign = "bottom";
        }
        # Player Status
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(${whatsong} --status)"'';
          color = "rgba(${colors.neutralLight}F0)";
          font_size = "14";
          font_family = font;
          position = "-770, 70";
          halign = "right";
          valign = "bottom";
        }
        # Player Source
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(${whatsong} --source)"'';
          color = "rgba(${colors.neutralLight}F0)";
          font_size = "10";
          font_family = font;
          position = "-770, 50";
          halign = "right";
          valign = "bottom";
        }
        # Player Album
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(${whatsong} --album)"'';
          color = "rgba(${colors.neutralLight}F0)";
          font_size = "10";
          font_family = font;
          position = "860, 50";
          halign = "left";
          valign = "bottom";
        }
        # Player Artist
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(${whatsong} --artist)"'';
          color = "rgba(${colors.neutralLight}F0)";
          font_size = "10";
          font_family = font;
          position = "860, 70";
          halign = "left";
          valign = "bottom";
        }
      ];
    };
  };
}
