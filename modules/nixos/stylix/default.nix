# System-wide theme tool
{ inputs, config, lib, ... }:

let
  moduleName = "stylix";
  cfg = config.modules.nixos.${moduleName};
in
{
  options.modules.nixos.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    imports = [
      inputs.stylix.nixosModules.stylix
    ];

    stylix = {
      enable = true;
      image = ./wallpaper.png;
    };
  };
}
