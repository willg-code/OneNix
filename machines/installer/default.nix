{
  modulesPath,
  lib,
  pkgs,
  ...
}: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  # Modules
  nixpkgs.hostPlatform = "x86_64-linux";
  services.openssh.settings.PermitRootLogin = lib.mkForce "no";
  environment.systemPackages = [pkgs.disko];
}
