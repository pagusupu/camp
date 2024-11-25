{inputs, ...}: {
  imports = with inputs; [
    git-hooks-nix.flakeModule
    treefmt-nix.flakeModule
  ];
  perSystem = {
    pkgs,
    inputs',
    config,
    ...
  }: {
    devShells.default = pkgs.mkShellNoCC {
      packages = [ inputs'.agenix.packages.default ];
      shellHook = config.pre-commit.installationScript;
    };
    pre-commit.settings = {
      hooks = {
        alejandra = {
          enable = true;
          package = config.packages.alejandra-custom;
        };
        deadnix.enable = true;
        statix.enable = true;
        nil.enable = true;
      };
      excludes = [ "flake.lock" ];
    };
    treefmt = {
      settings.global.excludes = [
        ".direnv/**"
        ".envrc"
        "flake.lock"
        "secrets/*.age"
      ];
      programs = {
        alejandra = {
          enable = true;
          package = config.packages.alejandra-custom;
        };
        deadnix.enable = true;
        mdformat.enable = true;
        statix.enable = true;
      };
      flakeCheck = false;
      projectRootFile = "flake.nix";
    };
  };
}
