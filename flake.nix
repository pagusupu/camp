{
  inputs = {
    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        darwin.follows = "";
        home-manager.follows = "";
      };
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "";
        nix-darwin.follows = "";
      };
    };
    aagl = {
      url = "github:ezKEa/aagl-gtk-on-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    anyrun = {
      url = "github:anyrun-org/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri.url = "github:sodiboo/niri-flake";
    nix-gaming.url = "github:fufexan/nix-gaming";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    qbit.url = "github:fsnkty/nixpkgs?ref=init-nixos-qbittorrent";
  };
  outputs = inputs: let
    inherit (inputs.nixpkgs.lib) genAttrs nixosSystem hasSuffix filesystem;
    inherit (builtins) concatMap filter;
    genHosts = hosts:
      genAttrs hosts (
        name:
          nixosSystem {
            modules =
              concatMap (x:
                filter (hasSuffix ".nix")
                (map toString (filesystem.listFilesRecursive x)))
              [./lib ./modules]
              ++ [./hosts/${name}.nix];
            specialArgs = {inherit inputs;};
          }
      );
  in {
    nixosConfigurations = genHosts [
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
