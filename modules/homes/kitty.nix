{ ... }:

{
  programs.kitty = {
    enable = true; # hyprland default terminal emulator
    settings = {
      shell = "zsh";
      enable_audio_bell = false;
      update_check_interval = 0;
      background_opacity = "0.8";
    };
  };

  # Hyprland integration
  wayland.windowManager.hyprland.settings.bind = [
    "$mainMod, Q, exec, kitty"
  ];
}
