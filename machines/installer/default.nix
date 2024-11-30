{modulesPath, ...}: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  # Modules
  modules.nixos.optimize-store.enable = true;
  boot.supportedFilesystems = ["bcachefs"]; # enable bcachefs install support
  nixpkgs.hostPlatform = "x86_64-linux";
}
