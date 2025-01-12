# Encrypted DNS proxy on localhost
{
  config,
  lib,
  ...
}: let
  moduleName = "dnscrypt-proxy";
  cfg = config.modules.nixos.${moduleName};
in {
  options.modules.nixos.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    networking.nameservers = ["1.1.1.1"];
    # networking.nameservers = ["127.0.0.1" "::1"]; # set dns to local nameserver
    # services.dnscrypt-proxy2 = {
    #   enable = true;
    #   settings = {
    #     ipv6_servers = true;
    #     require_dnssec = true;
    #     server_names = [ ];
    #   };
    # };

    # systemd.services.dnscrypt-proxy2.serviceConfig = {
    #   StateDirectory = "dnscrypt-proxy";
    # };
  };
}
