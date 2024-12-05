# Home level SSH: client and agent.
{
  config,
  lib,
  ...
}: let
  moduleName = "ssh";
  cfg = config.modules.home-manager.${moduleName};
in {
  options.modules.home-manager.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    sops.secrets."ssh_key".path = "${config.home.homeDirectory}/.ssh/${config.home.username}";
    services.ssh-agent.enable = true; # optionally remembers keys (bypasses password)
    programs.ssh = {
      enable = true; # ssh client
      addKeysToAgent = "1h"; # remember keys for 1 hour
      hashKnownHosts = true; # hash host IPs/names
      matchBlocks = {
        "default" = {
          host = "*";
          identityFile = config.sops.secrets."ssh_key".path;
        };
      }
    };
  };
}
