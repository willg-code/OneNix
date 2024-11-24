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
      primary = lib.mkOption { default = null; inherit type; };
      primaryHighlight = lib.mkOption { default = null; inherit type; };
      primaryLowlight = lib.mkOption { default = null; inherit type; };
      secondary = lib.mkOption { default = null; inherit type; };
      secondaryHighlight = lib.mkOption { default = null; inherit type; };
      secondaryLowlight = lib.mkOption { default = null; inherit type; };
      neutralLight = lib.mkOption { default = null; inherit type; };
      neutralDark = lib.mkOption { default = null; inherit type; };
    };

  config = {
    warnings =
      if (lib.any (e: e == null) (lib.attrValues cfg))
      then [ "one or more colors are not initialized" ]
      else [ ];
  };
}
