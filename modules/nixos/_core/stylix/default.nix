# System style unifier
{ ... }:

{
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  stylix = {
    image = lib.mkDefault ./theme-image.jpg;
  };
}
