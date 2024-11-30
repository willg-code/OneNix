{modulesPath, ...}: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  # Modules
  modules.nixos.optimize-store.enable = true;
  nixpkgs.hostPlatform = "x86_64-linux";
}
