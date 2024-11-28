{inputs, ...}: {
  nixpkgs.overlays = inputs.self.outputs.overlays;
}
