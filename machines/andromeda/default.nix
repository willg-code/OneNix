{ inputs, hostname, modules, ... }:

{
  imports = [
    modules.machines
    ./hardware-configuration.nix
  ];

  time.timeZone = "America/Louisville"; # based on location of the machine
  networking.hostName = hostname; # network host name
  system.stateVersion = "24.05";
}
