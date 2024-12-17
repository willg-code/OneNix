{
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.impermanence.homeManagerModules.impermanence
  ];

  home.persistence."/persist/home/${config.home.username}" = {
    allowOther = true; # allow other users to access home
    directories = [
      "Downloads"
      "Music"
      "Pictures"
      "Documents"
      "Videos"
      "git"
      ".local/share/applications" # for .desktop entries
      ".local/share/icons" # app icons
      ".local/share/systemd" # user systemd stuff
    ];
  };
}
