{ ... }:

{
  programs.hyprlock = {
    enable = true; # hyprland lock screen
    settings = {
      background = [
        {
          monitor = "";
          blur_passes = "2";
          brightness = "0.5";
        }
      ];
      label = [
        # Time
        {
          monitor = "";
          text = ''cmd[update:1000] echo "$(date +"%A, %B %d")"'';
          color = "rgba(242, 243, 244, 0.8)";
          font_size = "22";
          position = "0, 300"; # offset from center of screen
        }
        {
          monitor = "";
          text = "$TIME";
          color = "rgba(242, 243, 244, 0.8)";
          font_size = "95";
          position = "0, 200"; # offset from center of screen
        }
        # User Greeting
        {
          monitor = "";
          text = "Hello $DESC";
          color = "rgba(242, 243, 244, 0.8)";
          font_size = "22";
          position = "0, -150"; # offset from center of screen
        }
      ];
      input-field = [
        # Input Box
        {
          monitor = ""; # all monitors
          size = "250, 60";
          outline_thickness = "2";
          dots_size = "0.2"; # Scale of input-field height, 0.2 - 0.8
          dots_spacing = "0.35"; # Scale of dots' absolute size, 0.0 - 1.0
          outer_color = "rgba(0, 0, 0, 0)";
          inner_color = "rgba(0, 0, 0, 0.2)";
          font_color = "rgb(242, 243, 244)";
          fade_on_empty = "false"; # don't hide the field when it's empty
          check_color = "rgb(204, 136, 34)"; # color while validating password
          position = "0, -200"; # offset from center of screen;
        }
      ];
    };
  };
}
