# Wayland terminal emulator
{ config, lib, ... }:

let
  moduleName = "kitty";
  cfg = config.modules.home-manager.${moduleName};
in
{
  options.modules.home-manager.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    programs.kitty = {
      enable = true; # terminal emulator
      settings = {
        enable_audio_bell = false; # no sound on fail
        update_check_interval = 0; # don't check for updates
      };
    };

    # Hyprland integration
    wayland.windowManager.hyprland.settings.bind = [
      "$mainMod, Q, exec, uwsm app -- kitty"
    ];
  };
}
