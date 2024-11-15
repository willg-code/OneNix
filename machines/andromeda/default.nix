modules:
name:

{ config, ... }:

{
  imports = [
    modules.systemd-boot
    modules.hyprland
    modules.nvidia
    modules.pipewire
    modules.printing
    modules.sddm
    modules.steam
    ./hardware-configuration.nix
  ];

  time.timeZone = "America/Louisville"; # based on location of the machine
  networking.hostName = name; # network host name
  networking.networkmanager.enable = true; # automatically connects to network when possible
  system.stateVersion = "24.05";
}
