modules: name:

{ config, ... }:

{
  imports = [
    (modules.systemd-boot { logo = ./assets/andromeda.png; })
    modules.hyprland
    modules.nvidia
    modules.pipewire
    modules.printing
    modules.steam
    ./hardware.nix
  ];

  time.timeZone = "America/Louisville";
  networking.hostName = name;
  networking.networkmanager.enable = true;
  system.stateVersion = "24.05";
}
