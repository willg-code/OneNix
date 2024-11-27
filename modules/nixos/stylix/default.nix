# System-wide theme tool
{ inputs, config, lib, ... }:

let
  moduleName = "stylix";
  cfg = config.modules.nixos.${moduleName};
in
{
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  options.modules.nixos.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;
      image = ./theme-image.jpg;
    };
  };
}
