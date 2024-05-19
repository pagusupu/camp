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
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-mailserver = {
      url = "gitlab:simple-nixos-mailserver/nixos-mailserver/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-gaming.url = "github:fufexan/nix-gaming";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    qbit.url = "github:nu-nu-ko/nixpkgs?ref=init-nixos-qbittorrent";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };
  outputs = inputs: let
    inherit (inputs.nixpkgs) lib legacyPackages;
    inherit (lib) hasSuffix filesystem genAttrs nixosSystem;
    importAll = path:
      builtins.filter (hasSuffix ".nix")
      (map toString (filesystem.listFilesRecursive path));
  in {
    nixosConfigurations = genAttrs ["aoi" "rin"] (name:
      nixosSystem {
        specialArgs = {inherit inputs;};
        modules =
          [./hosts/${name}.nix]
          ++ importAll ./modules;
      });
    formatter.x86_64-linux = inputs.treefmt-nix.lib.mkWrapper legacyPackages.x86_64-linux {
      projectRootFile = "flake.nix";
      programs = {
        alejandra.enable = true;
        deadnix.enable = true;
        statix.enable = true;
      };
    };
  };
}
