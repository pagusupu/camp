{inputs, ...}: {
  imports = [
    inputs.git-hooks-nix.flakeModule
    inputs.treefmt.flakeModule
    ./devshell.nix
  ];
  perSystem = {
    pre-commit = {
      settings = {
        hooks = {
          alejandra.enable = true;
          deadnix.enable = true;
          statix.enable = true;
          nil.enable = true;
        };
        excludes = ["flake.lock"];
      };
      check.enable = true;
    };
    treefmt = {
      programs = {
        alejandra.enable = true;
        deadnix.enable = true;
        statix.enable = true;
      };
      #projectRootFile = "flake.nix";
    };
  };
}
