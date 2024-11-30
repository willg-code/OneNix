# Tell nix to optimize the store on each build
{
  config,
  lib,
  ...
}: let
  moduleName = "optimize-store";
  cfg = config.modules.nixos.${moduleName};
in {
  options.modules.nixos.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    nix.optimise = {
      automatic = true;
      dates = "daily";
    };
  };
}
