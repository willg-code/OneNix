# Tell nix to optimize the store every day
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
      automatic = true; # sets up a systemd timer with nix store optimise
      dates = ["daily"];
    };
  };
}
