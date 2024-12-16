{inputs, ...}: {
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  environment.persistence."/persist" = {
    hideMounts = true; # don't make the bind mounts visible in the mount table
    directories = [
      "/var/log" # logs
      "/var/lib/systemd" # necessary cross-boot systemd info
      "/var/tmp" # tmp files persisted across reboots
      "/var/lib/nixos" # necessary nixos state
    ];
    files = [
      "/etc/adjtime" # hardware clock offset
      "/etc/machine-id" # nixos expects this to be persisted
    ];
  };
}
