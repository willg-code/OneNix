# Steam install and configuration
# DOCS: https://nixos.wiki/wiki/Steam
{ ... }:

{
  nixpkgs.config.allowUnfree = true; # steam is unfree

  programs.steam = {
    enable = true; # install steam
    remotePlay.openFirewall = true; # open ports for remote play
    dedicatedServer.openFirewall = true; # open ports for steam server
    localNetworkGameTransfers.openFirewall = true; # open ports for local transfers
  };
}
