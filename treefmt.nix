{inputs, ...}: {
  perSystem.treefmt.config = {
    programs = {
      alejandra.enable = true;
      deadnix.enable = true;
      statix.enable = true;
    };
    projectRootFile = "flake.nix";
  };
  imports = [inputs.treefmt.flakeModule];
}
