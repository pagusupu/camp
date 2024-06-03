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
        nix-darwin.follows = "";
        home-manager.follows = "";
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
    base16.url = "github:SenchoPens/base16.nix";
    niri.url = "github:sodiboo/niri-flake";
    nix-gaming.url = "github:fufexan/nix-gaming";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    qbit.url = "github:nu-nu-ko/nixpkgs?ref=init-nixos-qbittorrent";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };
  outputs = inputs: let
    inherit (inputs) nixpkgs treefmt-nix;
    inherit (nixpkgs) legacyPackages lib;
    inherit (lib) hasSuffix filesystem;
    inherit (builtins) concatMap filter;
  in {
    colmena = {
      meta = {
        nixpkgs = legacyPackages.x86_64-linux;
        specialArgs = {inherit inputs;};
      };
      defaults = {name, ...}: {
        imports =
          concatMap (x:
            filter (hasSuffix ".nix")
            (map toString (filesystem.listFilesRecursive x)))
          [
            ./lib
            ./modules
          ]
          ++ [./hosts/${name}.nix];
      };
      rin.deployment = {
        allowLocalDeployment = true;
        targetHost = null;
      };
      aoi.deployment = {
        targetUser = "pagu";
        targetHost = "192.168.178.182";
      };
    };
    formatter.x86_64-linux = treefmt-nix.lib.mkWrapper legacyPackages.x86_64-linux {
      projectRootFile = "flake.nix";
      programs = {
        alejandra.enable = true;
        deadnix.enable = true;
        statix.enable = true;
        yamlfmt.enable = true;
      };
    };
  };
}
