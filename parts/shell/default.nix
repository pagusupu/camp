{inputs, ...}: {
  imports = with inputs; [
    git-hooks-nix.flakeModule
    treefmt.flakeModule
  ];
  perSystem = {
    pkgs,
    inputs',
    config,
    ...
  }: {
    devShells.default = pkgs.mkShell {
      packages = [inputs'.agenix.packages.default];
      shellHook = config.pre-commit.installationScript;
    };
    pre-commit.settings = {
      hooks = {
        deadnix.enable = true;
        statix.enable = true;
        nil.enable = true;
      };
      excludes = ["flake.lock"];
    };
    treefmt = {
      settings.global.excludes = [
        ".direnv/**"
        ".envrc"
        "secrets/*.age"
      ];
      programs = {
        alejandra.enable = true;
        deadnix.enable = true;
        mdformat.enable = true;
        statix.enable = true;
      };
      flakeCheck = false;
      projectRootFile = "flake.nix";
    };
  };
}
