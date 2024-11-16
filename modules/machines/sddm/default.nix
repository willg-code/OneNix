# Graphical login manager
{ pkgs, ... }:

{
  environment.systemPackages = [
    # theme package
    (pkgs.catppuccin-sddm.override {
      flavor = "mocha";
      font = "Noto Sans";
      fontSize = "9";
      background = "${./wallpaper.png}";
      loginBackground = true;
    })
  ];

  services.displayManager.sddm = {
    enable = true; # login screen compatible with hyprland
    wayland.enable = true; # native wayland support
    theme = "catppuccin-mocha"; # enable the previously declared theme
  };
}
