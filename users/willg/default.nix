{ home, home-modules }:
{ inputs, hostname, config, lib, secrets, ... }:

{
  # Secrets
  sops.secrets = {
    "willg_password".neededForUsers = true;
    "willg_name".neededForUsers = true;
  };
  users.users.willg = {
    isNormalUser = true; # set group to users and creates a home at /home/willg
    extraGroups = [ "wheel" ] # sudo user group
      ++ lib.optionals config.networking.networkmanager.enable [ "networkmanager" ] # non-sudo network manager permissions
      ++ lib.optionals config.virtualisation.docker.enable [ "docker" ]; # non-sudo docker permissions
    hashedPasswordFile = config.sops.secrets."willg_password".path;
    openssh.authorizedKeys.keyFiles = [
      ./pubkeys/willg.pub # allow ssh from any other machine with this user account
    ];
    description = lib.readFile config.sops.secrets."willg_name".path;
  };

  # HM modules
  home-manager.users.${username} = {
    imports = [ home ] ++ home-modules;
    _module.args = {
      inherit inputs hostname;
      username = "willg";
      desc = config.users.users.willg.description;
    };
  };
}
