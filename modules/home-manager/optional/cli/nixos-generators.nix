# ISO generator tool
{
  config,
  lib,
  pkgs,
  ...
}: let
  moduleName = "nixos-generators";
  cfg = config.modules.home-manager.${moduleName};
in {
  options.modules.home-manager.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    home.packages = [
      pkgs.nixos-generators # iso generators
    ];
  };
}
