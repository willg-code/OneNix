{
  config,
  lib,
  ...
}: let
  moduleName = "hyprland";
  cfg = config.modules.home-manager.${moduleName};
in {
  options.modules.home-manager.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  imports = [
    ./binds.nix
    ./decoration.nix
    ./dwindle.nix
    ./general.nix
    ./input.nix
    ./misc.nix
    ./monitors.nix
    ./windowrules.nix
    ./workspaces.nix
    ./xwayland.nix
  ];

  config = lib.mkIf cfg.enable {
    home.sessionVariables.NIXOS_OZONE_WL = "1"; # make electron apps use wayland

    # Hyprland config
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false; # disable systemd integration to use UWSM
    };

    # Hypridle integration
    services.hypridle.settings = {
      general.after_sleep_cmd = "hyprctl dispatch dpms on"; # to avoid having to press a key a second time after wake
      listener = [
        {
          timeout = "330"; # 5.5min
          on-timeout = "hyprctl dispatch dpms off"; # screen off when timeout has passed
          on-resume = "hyprctl dispatch dpms on"; # screen on when activity is detected
        }
      ];
    };
  };
}
