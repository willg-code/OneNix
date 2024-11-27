# Common font configuration for all systems
{ inputs, config, lib, pkgs, ... }:

let
  moduleName = "fonts";
  cfg = config.modules.home-manager.${moduleName};
in
{
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  options.modules.home-manager.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    stylix.fonts = {
      sansSerif = {
        package = pkgs.noto-fonts;
        name = "Noto Sans";
      };
      serif = {
        package = pkgs.noto-fonts;
        name = "Noto Serif";
      };
      monospace = {
        package = pkgs.nerdfonts.override { fonts = [ "Noto" ]; };
        name = "NotoMono Nerd Font";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
    };
  };
}

