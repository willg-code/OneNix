# Common font configuration for all systems
{
  config,
  lib,
  pkgs,
  ...
}: let
  moduleName = "notonerd-fonts";
  cfg = config.modules.home-manager.${moduleName};
in {
  options.modules.home-manager.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.nerd-fonts.symbols-only
    ];
    stylix = {
      enable = true;
      fonts = {
        sansSerif = {
          package = pkgs.noto-fonts;
          name = "Noto Sans";
        };
        serif = {
          package = pkgs.noto-fonts;
          name = "Noto Serif";
        };
        monospace = {
          package = pkgs.noto-fonts;
          name = "Noto Sans Mono";
        };
        emoji = {
          package = pkgs.noto-fonts-monochrome-emoji;
          name = "Noto Emoji";
        };
      };
    };
  };
}
