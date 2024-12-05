{
  # persist logs
  environment.persistence."/persistent".directories = [
    "/var/log"
    "/var/lib/systemd/coredump"
  ];
}
