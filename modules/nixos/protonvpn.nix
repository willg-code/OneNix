# Proton VPN configuration
{ config, lib, ... }:

let
  moduleName = "protonvpn";
  cfg = config.modules.nixos.${moduleName};
in
{
  options.modules.nixos.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    sops.secrets."proton_key" = { };


    systemd.network.netdevs.protonvpn = {
      enable = true; # VPN Device
      # Config
      wireguardConfig = {
        PrivateKeyFile = config.sops.secrets."proton_key".path;
        Address = "10.2.0.2/32";
        DNS = "10.2.0.1";
      };
      #Peers
      wireguardPeers = {
        # US-IL#159
        PublicKey = "xuqP9uEGryELhamLSK9IDRNhljo3lA1zL9/gS7yj2WQ=";
        AllowedIPs = "0.0.0.0/0";
        Endpoint = "87.249.134.139:51820";
      };
    };
  };
}
