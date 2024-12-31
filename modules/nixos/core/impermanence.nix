{inputs, ...}: {
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  environment.persistence."/persist" = {
    hideMounts = true; # don't make the bind mounts visible in the mount table
    directories = [
      "/var/lib/systemd" # necessary cross-boot systemd info
      "/var/lib/nixos" # necessary nixos state
      "/var/log" # logs
      "/var/tmp" # tmp files persisted across reboots
      "/var/db/sudo/lectured" # lectured state, lectures on first sudo
    ];
    files = [
      "/etc/adjtime" # hardware clock offset
      "/etc/machine-id" # nixos expects this to be persisted
    ];
  };
}
