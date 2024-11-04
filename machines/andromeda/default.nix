modules: 

{ config, ... }:

{
  imports = [
    modules.grub
    modules.hyprland
    modules.nvidia
    modules.pipewire
    modules.printing
    modules.steam
  ];

  time.timeZone = "America/Louisville";
  networking.hostName = config.current.name;
  system.stateVersion = "24.05";
}