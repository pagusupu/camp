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
    inherit (inputs.nixpkgs.legacyPackages) x86_64-linux;
    inherit (inputs.nixpkgs.lib) genAttrs nixosSystem hasSuffix filesystem;
    specialArgs = {inherit inputs;};
    filter = builtins.concatMap (
      x:
        builtins.filter (hasSuffix ".nix")
        (map toString (filesystem.listFilesRecursive x))
    );
    genHosts = hosts:
      genAttrs hosts (
        name:
          nixosSystem {
            inherit specialArgs;
            modules = filter [./lib ./modules] ++ [./hosts/${name}.nix];
          }
      );
  in {
    nixosConfigurations = genHosts [
      "aoi"
      "rin"
    ];
    colmena = {
      meta = {
        nixpkgs = x86_64-linux;
        inherit specialArgs;
      };
      defaults = {name, ...}: {
        deployment = {
          allowLocalDeployment = true;
          buildOnTarget = true;
          targetUser = "pagu";
        };
        imports = filter [./lib ./modules] ++ [./hosts/${name}.nix];
      };
      aoi.deployment.targetHost = "192.168.178.182";
      rin.deployment.targetHost = null;
    };
    formatter.x86_64-linux = inputs.treefmt-nix.lib.mkWrapper x86_64-linux {
      programs = {
        alejandra.enable = true;
        deadnix.enable = true;
        statix.enable = true;
      };
      projectRootFile = "flake.nix";
    };
  };
}
