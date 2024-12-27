# Steam install and configuration
# DOCS: https://nixos.wiki/wiki/Steam
{
  config,
  lib,
  pkgs,
  ...
}: let
  moduleName = "steam";
  cfg = config.modules.nixos.${moduleName};
in {
  options.modules.nixos.${moduleName} = {
    enable = lib.mkEnableOption moduleName;
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = [
      pkgs.gamescope
    ];
    nixpkgs.config.allowUnfree = true; # steam is unfree
    programs.steam = {
      enable = true; # install steam
      remotePlay.openFirewall = true; # open ports for remote play
      dedicatedServer.openFirewall = true; # open ports for steam server
      localNetworkGameTransfers.openFirewall = true; # open ports for local transfers
    };
  };
}
