{ hostname, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  # Modules
  modules.machines.bluetooth.enable = true;
  modules.machines.hyprland.enable = true;
  modules.machines.networkmanager.enable = true;
  modules.machines.nvidia.enable = true;
  modules.machines.pipewire.enable = true;
  modules.machines.printing.enable = true;
  modules.machines.sddm.enable = true;
  modules.machines.sshd.enable = true;
  modules.machines.steam.enable = true;
  modules.machines.systemd-boot.enable = true;

  # Other
  time.timeZone = "America/Louisville"; # based on location of the machine
  networking.hostName = hostname; # network host name
  system.stateVersion = "24.05";
}
