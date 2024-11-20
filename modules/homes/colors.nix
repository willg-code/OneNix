{ config, lib, ... }:

let
  moduleName = "colors";
  cfg = config.modules.${moduleName};
in
{
  options.modules.${moduleName} =
    let
      type = (lib.types.nullOr lib.types.uniq lib.types.str);
    in
    {
      primary = lib.mkOption { inherit type; };
      primaryHighlight = lib.mkOption { inherit type; };
      primaryLowlight = lib.mkOption { inherit type; };
      secondary = lib.mkOption { inherit type; };
      secondaryHighlight = lib.mkOption { inherit type; };
      secondaryLowlight = lib.mkOption { inherit type; };
    };

  config = {
    warnings =
      if (lib.any (e: e == null) (lib.attrValues cfg))
      then [ "one or more colors are not initialized" ]
      else [ ];
  };
}
