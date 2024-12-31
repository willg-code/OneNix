{pkgs, ...}: {
  imports = [
    ./hardware.nix
    ./disko.nix
  ];

  # Modules
  modules.nixos.bluetooth.enable = true;
  modules.nixos.gamemode.enable = true;
  modules.nixos.hyprland.enable = true;
  modules.nixos.networkmanager.enable = true;
  modules.nixos.nvidia.enable = true;
  modules.nixos.optimize-store.enable = true;
  modules.nixos.pipewire.enable = true;
  modules.nixos.printing.enable = true;
  modules.nixos.regreet.enable = true;
  modules.nixos.steam.enable = true;
  modules.nixos.systemd-boot.enable = true;

  stylix = {
    enable = true;
    image = ./assets/andromeda.jpg;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/atelier-sulphurpool.yaml";
  };

  # Other
  time.timeZone = "America/Louisville"; # based on location of the machine
  networking.hostName = "andromeda"; # network host name
  system.stateVersion = "24.11";
}
