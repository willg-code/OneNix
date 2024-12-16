# Graphical login manager
{
  config,
  lib,
  pkgs,
  ...
}: let
  moduleName = "sddm";
  cfg = config.modules.nixos.${moduleName};
in {
  options.modules.nixos.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      # theme package
      (pkgs.catppuccin-sddm.override {
        flavor = "mocha";
        font = "Noto Sans";
        fontSize = "9";
        background = "${config.stylix.image}";
        loginBackground = true;
      })
    ];

    services.displayManager.sddm = {
      enable = true; # login screen compatible with hyprland
      wayland.enable = true; # native wayland support
      theme = "catppuccin-mocha"; # enable the previously declared theme
      package = pkgs.kdePackages.sddm; # more up-to-date package to fix theme
    };

    environment.persistence."/persistent".files = [
      "/var/lib/sddm/state.conf"
    ];
  };
}
