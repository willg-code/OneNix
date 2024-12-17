home: {
  config,
  lib,
  ...
}: {
  # Secrets
  sops.secrets."willg_password".neededForUsers = true;

  # User config
  users.users.willg = {
    isNormalUser = true; # set group to users and creates a home dir
    extraGroups =
      ["wheel"] # sudo user group
      ++ lib.optionals config.networking.networkmanager.enable ["networkmanager"] # non-sudo network manager permissions
      ++ lib.optionals config.virtualisation.docker.enable ["docker"] # non-sudo docker permissions
      ++ lib.optionals config.programs.gamemode.enable ["gamemode"]; # allow gamemode to change cpu priority
    hashedPasswordFile = config.sops.secrets."willg_password".path; # password from sops
    openssh.authorizedKeys.keyFiles = [
      ./pubkeys/willg.pub # allow ssh from any other machine with this user account
    ];
    description = "Will G.";
  };

  systemd.tmpfiles.rules = ["d /persist/willg 1700 willg willg"]; # persistent home dir

  # HM modules
  home-manager.users.willg = {
    imports = [home];
    _module.args.email = "greenlee04@gmail.com";
    home.username = "willg";
    home.homeDirectory = "/home/willg";
    home.shellAliases = {
      lfr = ''sudo find / -xdev -type f ! -path "*/.cache/*"'';
    };
  };
}
