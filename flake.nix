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
      url = "github:Kirottu/anyrun";
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
    filter-nix = builtins.concatMap (
      x: builtins.filter (hasSuffix ".nix") (map toString (filesystem.listFilesRecursive x))
    );
    specialArgs = {inherit inputs;};
  in let
    genHosts = hosts:
      genAttrs hosts (
        name:
          nixosSystem {
            modules = filter-nix [./lib ./modules] ++ [./hosts/${name}.nix];
            inherit specialArgs;
          }
      );
  in {
    nixosConfigurations = genHosts [
      "aoi"
      "rin"
    ];
    colmena = {
      meta = {
        nixpkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
        inherit specialArgs;
      };
      defaults = {name, ...}: {
        imports = filter-nix [./lib ./modules] ++ [./hosts/${name}.nix];
        deployment = {
          allowLocalDeployment = true;
          buildOnTarget = true;
          targetUser = "pagu";
        };
      };
      aoi.deployment.targetHost = "192.168.178.182";
      rin.deployment.targetHost = null;
    };
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
