# WPA Supplicant global configuration
# DOCS: https://nixos.wiki/wiki/Wpa_supplicant
{
  config,
  lib,
  ...
}: let
  moduleName = "wireless";
  cfg = config.modules.nixos.${moduleName};
in {
  options.modules.nixos.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    # Secrets
    sops.secrets."wpa_secrets" = {};

    # Global Config
    networking.wireless = {
      enable = true;
      secretsFile = config.sops.secrets."wpa_secrets".path;
      networks = {
        "LCA Members".pskRaw = "ext:psk_lca_members";
        "LCA Guest".pskRaw = "ext:psk_lca_guest";
        "greenlee2".pskRaw = "ext:psk_greenlee2";
      };
    };
  };
}
