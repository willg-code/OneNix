{inputs, ...}: {
  imports = [
    inputs.impermanence.nixosModules.impermanence
  ];

  environment.persistence."/persistent" = {
    hideMounts = true; # don't make the bind mounts visible in the mount table
    directories = [
      "/var/log" # logs
      "/var/tmp" # tmp files persisted across reboots
      "/var/lib/systemd/" #systemd state
    ];
  };

  # Swap for low-memory systems
  swapDevices = [ 
    {
      device = "/var/tmp/swapfile";
      size = 48*1024; # 48 GiB
    } 
  ];
}
