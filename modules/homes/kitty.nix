# Pretty terminal emulator, 
# works beautifully with hyprland
{ inputs, pkgs, ... }:

{
  programs.kitty = {
    enable = true; # terminal emulator
    settings = {
      enable_audio_bell = false; # no sound on fail
      update_check_interval = 0; # don't check for updates
      background_opacity = "0.9"; # slightly transparent background
    };
  };

  # Hyprland integration
  wayland.windowManager.hyprland.settings.bind = [
    "$mainMod, Q, exec, kitty"
  ];
}
