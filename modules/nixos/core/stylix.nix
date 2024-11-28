# System style unifier
{ inputs, ... }:

{
  imports = [
    inputs.stylix.nixosModules.stylix
  ];
}
