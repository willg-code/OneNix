# recursive so config can access name and email
rec {
  config =
    username:
    { config, lib, modules, ... }:
    {
      users.users.${username} = {
        isNormalUser = true; # set group to users and creates a home at /home/<username>
        extraGroups = [ "wheel" ] # sudo user group
          ++ lib.optionals config.networking.networkmanager.enable [ "networkmanager" ] # non-sudo network manager permissions
          ++ lib.optionals config.virtualisation.docker.enable [ "docker" ]; # non-sudo docker permissions
        initialPassword = ""; # no initial password, set on first login
        openssh.authorizedKeys.keyFiles = [
          ./pubkeys/willg.pub # allow ssh from any other machine with this user account
        ];
        description = name; # set description to nicely formatted name
      };
    };

  name = "Will G.";
  email = "greenlee04@gmail.com";
}
