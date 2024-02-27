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
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-mailserver = {
      url = "gitlab:simple-nixos-mailserver/nixos-mailserver";
      inputs.nixpkgs.follows = "nixpkgs";
    }; 
    ags.url = "github:Aylur/ags";
    conduit.url = "gitlab:famedly/conduit?ref=next";
    hyprland.url = "github:hyprwm/Hyprland";
    nix-gaming.url = "github:fufexan/nix-gaming";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    qbit.url = "github:nu-nu-ko/nixpkgs?ref=init-nixos-qbittorrent";
  };
  outputs = inputs: let
    inherit (inputs.nixpkgs) lib;
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
  };
}
