# Networkmanager, dynamically ensures a network connection is
# used if it is available
{
  config,
  lib,
  ...
}: let
  moduleName = "networkmanager";
  cfg = config.modules.nixos.${moduleName};
in {
  options.modules.nixos.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    networking.networkmanager.enable = true; # networkmanager
    #networking.nameservers = ["1.1.1.1"]; # Cloudflare
    networking.nameservers = ["137.112.18.100"]; # Cache DNS
  };
}
