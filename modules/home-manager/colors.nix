{ config, lib, ... }:

let
  moduleName = "colors";
  cfg = config.modules.home-manager.${moduleName};
in
{
  options.modules.home-manager.${moduleName} =
    let
      type = (lib.types.nullOr (lib.types.uniq lib.types.str));
    in
    {
      enable = lib.mkEnableOption moduleName;
      primary = lib.mkOption { default = null; inherit type; };
      primaryHighlight = lib.mkOption { default = null; inherit type; };
      primaryLowlight = lib.mkOption { default = null; inherit type; };
      secondary = lib.mkOption { default = null; inherit type; };
      secondaryHighlight = lib.mkOption { default = null; inherit type; };
      secondaryLowlight = lib.mkOption { default = null; inherit type; };
      neutralLight = lib.mkOption { default = null; inherit type; };
      neutralDark = lib.mkOption { default = null; inherit type; };
    };

  config = lib.mkIf cfg.enable {
    assertions = [
      {
        assertion = !(lib.any (e: e == null) (lib.attrValues cfg));
        message = "one or more colors has not been initialized";
      }
    ];
  };
}
