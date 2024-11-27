# Home level SSH config: client and agent.
{ config, lib, secrets, inputs, ... }:


let
  moduleName = "ssh";
  cfg = config.modules.home-manager.${moduleName};
in
{
  options.modules.home-manager.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    sops.secrets."ssh_key".path = "${config.home.homeDirectory}/.ssh/${config.home.username}";
    services.ssh-agent.enable = true; # optionally remembers keys used for authentication
    programs.ssh = {
      enable = true; # ssh client
      addKeysToAgent = "1h"; # remember keys for 1 hour in memory with ssh-agent
    };
  };
}
