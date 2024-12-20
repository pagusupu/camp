{inputs, ...}: {
  imports = with inputs; [
    git-hooks-nix.flakeModule
    treefmt-nix.flakeModule
    flake-parts.flakeModules.easyOverlay
  ];
  perSystem = {
    pkgs,
    inputs',
    config,
    lib,
    ...
  }: let
    alejandra = {
      enable = true;
      package = config.packages.alejandra-custom;
    };
  in {
    devShells.default = pkgs.mkShell {
      packages = [ inputs'.agenix.packages.default ];
      shellHook = config.pre-commit.installationScript;
    };
    pre-commit.settings = {
      hooks = {
        inherit alejandra;
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
        "parts/secrets/*.age"
      ];
      programs = {
        inherit alejandra;
        deadnix.enable = true;
        mdformat.enable = true;
        statix.enable = true;
      };
      flakeCheck = false;
      projectRootFile = "flake.nix";
    };
    packages = lib.mkMerge [
      (lib.packagesFromDirectoryRecursive {
        directory = ./pkgs;
        inherit (pkgs) callPackage;
      })
      { nix = pkgs.lix; }
    ];
    overlayAttrs = config.packages;
  };
}
