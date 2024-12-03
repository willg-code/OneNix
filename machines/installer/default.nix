{modulesPath, ...}: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  # Modules
  nixpkgs.hostPlatform = "x86_64-linux";
}
