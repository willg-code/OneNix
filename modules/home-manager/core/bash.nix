# Bourne Again Shell
{config, ...}: {
  home.persistence."/persist/home/${config.home.username}".files = [
    ".bash_history" # nice to have shell history
  ];
}
