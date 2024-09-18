{
  inputs = {
    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lix-module = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    qbit.url = "github:fsnkty/nixpkgs?ref=init-nixos-qbittorrent";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };
  outputs = inputs: let
    inherit (inputs.nixpkgs.lib) genAttrs nixosSystem hasSuffix filesystem;
    inherit (builtins) concatMap filter;
    mkHost = hosts:
      genAttrs hosts (
        name:
          nixosSystem {
            modules =
              concatMap (x:
                filter (hasSuffix ".nix")
                (map toString (filesystem.listFilesRecursive x)))
              [./lib ./modules]
              ++ [./hosts/${name}.nix]
              ++ [inputs.lix-module.nixosModules.default];
            specialArgs = {inherit inputs;};
          }
      );
  in {
    nixosConfigurations = mkHost [
      "aoi"
      "rin"
    ];
    formatter.x86_64-linux = inputs.treefmt-nix.lib.mkWrapper
    inputs.nixpkgs.legacyPackages.x86_64-linux {
      programs = {
        alejandra.enable = true;
        deadnix.enable = true;
        statix.enable = true;
      };
      projectRootFile = "flake.nix";
    };
  };
}
