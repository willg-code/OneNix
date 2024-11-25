home:
{ inputs, hostname, config, lib, secrets, ... }:

{
  # Secrets
  sops.secrets = {
    "willg_password".neededForUsers = true;
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
    description = "Will G.";
  };

  # HM modules
  home-manager.users.willg = {
    imports = home;
    _module.args = {
      inherit hostname secrets;
      username = "willg";
      email = "greenlee04@gmail.com";
    };
  };
}
