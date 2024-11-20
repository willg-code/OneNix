# Graphical login manager
{ config, lib, pkgs, ... }:

let
  moduleName = "sddm";
  cfg = config.modules.machines.${moduleName};
in
{
  options.modules.machines.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      # theme package
      (pkgs.catppuccin-sddm.override {
        flavor = "mocha";
        font = "Noto Sans";
        fontSize = "9";
        background = "${./wallpaper.jpg}";
        loginBackground = true;
      })
    ];

    services.displayManager.sddm = {
      enable = true; # login screen compatible with hyprland
      wayland.enable = true; # native wayland support
      theme = "catppuccin-mocha"; # enable the previously declared theme
      package = pkgs.kdePackages.sddm; # more up-to-date package to fix theme
    };
  };
}
