{inputs, ...}: {
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  environment.persistence."/persistent" = {
    hideMounts = true; # don't make the bind mounts visible in the mount table
  };
}
