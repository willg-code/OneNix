# Steam install and configuration
# DOCS: https://nixos.wiki/wiki/Steam
{ config, lib, ... }:

let
  moduleName = "steam";
  cfg = config.modules.machines.${moduleName};
in
{
  options.modules.machines.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    nixpkgs.config.allowUnfree = true; # steam is unfree
    programs.steam = {
      enable = true; # install steam
      remotePlay.openFirewall = true; # open ports for remote play
      dedicatedServer.openFirewall = true; # open ports for steam server
      localNetworkGameTransfers.openFirewall = true; # open ports for local transfers
    };
  };
}
