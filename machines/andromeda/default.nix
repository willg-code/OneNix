{pkgs, ...}: {
  imports = [
    ./hardware.nix
    ./disko.nix
  ];

  # Modules
  modules.nixos.bluetooth.enable = true;
  modules.nixos.dnscrypt-proxy.enable = true;
  modules.nixos.gamemode.enable = true;
  modules.nixos.hyprland.enable = true;
  modules.nixos.nvidia.enable = true;
  modules.nixos.optimize-store.enable = true;
  modules.nixos.pipewire.enable = true;
  modules.nixos.printing.enable = true;
  modules.nixos.regreet.enable = true;
  modules.nixos.steam.enable = true;
  modules.nixos.systemd-boot.enable = true;
  modules.nixos.wireless.enable = true;

  stylix = {
    enable = true;
    image = ./assets/andromeda.jpg;
    polarity = "dark";
    base16Scheme = "${pkgs.base16-schemes}/share/themes/atelier-sulphurpool.yaml";
  };

  # NOTE: networking.useDHCP = true; will cause only one of these to be required to be routable for boot
  systemd.network = {
    enable = true;
    networks = {
      "1-enp7s0" = {
        matchConfig.Name = "enp7s0";
        networkConfig = {
          DHCP = "ipv4";
          IPv6AcceptRA = true; # accept Router Advertisements for Stateless IPv6 Autoconfiguraton (SLAAC)
        };
        linkConfig.RequiredForOnline = "routable";
      };
      # further configured with WPA_Supplicant in wireless module
      "2-wlp6s0" = {
        matchConfig.Name = "wlp6s0";
        networkConfig = {
          DHCP = "ipv4";
          IPv6AcceptRA = true; # accept Router Advertisements for Stateless IPv6 Autoconfiguraton (SLAAC)
        };
        linkConfig.RequiredForOnline = "routable";
      };
    };
  };

  # Other
  time.timeZone = "America/Louisville"; # based on location of the machine
  networking.hostName = "andromeda"; # network host name
  system.stateVersion = "24.11";
}
