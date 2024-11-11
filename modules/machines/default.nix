{
  systemd-boot = import ./systemd-boot.nix;
  hyprland = import ./hyprland.nix;
  nvidia = import ./nvidia.nix;
  pipewire = import ./pipewire.nix;
  printing = import ./printing.nix;
  steam = import ./steam.nix;
}
