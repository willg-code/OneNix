{ inputs, hostname, modules, ... }:

{
  imports = [
    modules.machines
    ./hardware-configuration.nix
  ];

  # Modules
  modules.machines.systemd-boot.enable = true;

  # Other
  time.timeZone = "America/Louisville"; # based on location of the machine
  networking.hostName = hostname; # network host name
  system.stateVersion = "24.05";
}
