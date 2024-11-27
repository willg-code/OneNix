# Phinger cursor theme integration with stylix
{ inputs, config, lib, pkgs, ... }:

let
  moduleName = "phinger-cursor";
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
    stylix = {
      enable = true;
      cursor = {
        package = pkgs.phinger-cursors;
        name = "phinger-cursors-light";
      };
    };
  };
}
