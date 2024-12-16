{
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.impermanence.homeManagerModules.impermanence
  ];

  home.persistence."/persist/home/${config.home.username}" = {
    directories = [
      "Downloads"
      "Music"
      "Pictures"
      "Documents"
      "Videos"
      "git"
    ];
  };
}
