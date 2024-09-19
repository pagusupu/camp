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
    lix = {
      url = "https://git.lix.systems/lix-project/nixos-module/archive/2.91.0.tar.gz";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    qbit.url = "github:fsnkty/nixpkgs?ref=init-nixos-qbittorrent";
    treefmt.url = "github:numtide/treefmt-nix";
  };
  outputs = {systems, ...} @ inputs: let
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
              ++ [inputs.lix.nixosModules.default];
            specialArgs = {inherit inputs;};
          }
      );
  in {
    nixosConfigurations = mkHost [
      "aoi"
      "rin"
    ];
    formatter = let
      eachSystem = f: genAttrs (import systems) (system: f inputs.nixpkgs.legacyPackages.${system});
      treefmtEval = eachSystem (pkgs: inputs.treefmt.lib.evalModule pkgs ./treefmt.nix);
    in
      eachSystem (pkgs: treefmtEval.${pkgs.system}.config.build.wrapper);
  };
}
