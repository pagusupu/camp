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
      url = "gitlab:simple-nixos-mailserver/nixos-mailserver";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ags.url = "github:Aylur/ags";
    base16.url = "github:SenchoPens/base16.nix";
    nix-gaming.url = "github:fufexan/nix-gaming";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    qbit.url = "github:nu-nu-ko/nixpkgs?ref=init-nixos-qbittorrent";
    treefmt-nix.url = "github:numtide/treefmt-nix";
  };
  outputs = inputs: let
    inherit (inputs.nixpkgs) lib legacyPackages;
    importAll = path:
      builtins.filter (lib.hasSuffix ".nix")
      (map toString (lib.filesystem.listFilesRecursive path));
  in {
    nixosConfigurations = lib.genAttrs ["desktop" "nixserver"] (name:
      lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules =
          [./hosts/${name}.nix]
          ++ importAll ./modules;
      });
    formatter.x86_64-linux = inputs.treefmt-nix.lib.mkWrapper legacyPackages.x86_64-linux {
      projectRootFile = "flake.nix";
      programs = {
        alejandra.enable = true;
        biome.enable = false; # for ags when i finally start
        deadnix.enable = true;
        yamlfmt.enable = true;
      };
    };
  };
}
