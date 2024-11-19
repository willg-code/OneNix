modules:

{ inputs, hostname, ... }:

{
  imports = [
    modules.bluetooth
    modules.hyprland
    modules.networkmanager
    modules.nvidia
    modules.pipewire
    modules.printing
    modules.speechd
    modules.sshd
    modules.sddm
    modules.steam
    modules.systemd-boot
    ./hardware-configuration.nix
  ];

  time.timeZone = "America/Louisville"; # based on location of the machine
  networking.hostName = hostname; # network host name
  system.stateVersion = "24.05";
}
