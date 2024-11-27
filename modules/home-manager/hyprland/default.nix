{ config, lib, pkgs, ... }:

let
  moduleName = "hyprland";
  cfg = config.modules.home-manager.${moduleName};
in
{
  options.modules.home-manager.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  imports = [
    ./binds.nix
    ./decoration.nix
    ./dwindle.nix
    ./general.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./input.nix
    ./misc.nix
    ./monitors.nix
    ./windowrules.nix
  ];

  config = lib.mkIf cfg.enable {

    # Required dependencies for this module
    home.packages = [
      pkgs.hyprpicker # color picker for hyprland
      pkgs.wl-clipboard-rs # wl-clipboard implementation, required for hyprpicker -a
      pkgs.hyprpolkitagent # polkit agent
    ];

    home.sessionVariables.NIXOS_OZONE_WL = "1"; # make electron apps use wayland

    # Hyprland config
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false; # disable systemd integration to use UWSM
      settings = {
        exec-once = [
          "uwsm app -- hypridle" # start idle daemon
          "systemctl --user enable --now hyprpolkitagent.service" # start polkit daemon
        ];
      };
    };
    services.hypridle.enable = true; # hyprland idle daemon
    programs.hyprlock.enable = true; # hyprland lock screen
  };
}
