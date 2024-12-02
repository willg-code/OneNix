{
  environment.persistence."/persistent".directories = [
    "/tmp" # for large builds, will get cleaned on reboot
  ];
  boot.tmp.cleanOnBoot = true; # clean up /tmp on boot
}