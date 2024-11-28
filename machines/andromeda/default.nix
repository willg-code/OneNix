{
  hostname,
  config,
  secrets,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  # Modules
  modules.nixos.bluetooth.enable = true;
  modules.nixos.hyprland.enable = true;
  modules.nixos.networkmanager.enable = true;
  modules.nixos.nvidia.enable = true;
  modules.nixos.pipewire.enable = true;
  modules.nixos.printing.enable = true;
  modules.nixos.sddm.enable = true;
  modules.nixos.steam.enable = true;
  modules.nixos.systemd-boot.enable = true;

  # Stylix
  stylix.enable = true;
  stylix.image = ./assets/theme-image.jpg;
  stylix.polarity = "dark";

  # Other
  time.timeZone = "America/Louisville"; # based on location of the machine
  networking.hostName = hostname; # network host name
  system.stateVersion = "24.05";
}
