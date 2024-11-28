# Global home manager config
{
  inputs,
  hostname,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];

  home-manager.useUserPackages = true; # home packages install at host level (not in home)
  home-manager.useGlobalPkgs = true; # use the host level pkgs instance
  home-manager.extraSpecialArgs = {inherit inputs;}; # inputs need to be a special arg
  home-manager.sharedModules = [
    inputs.self.outputs.homeManagerModules.default # import modules
    {_module.args.hostname = hostname;} # pass along hostname
  ];
}