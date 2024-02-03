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
      inputs.nixpkgs.follows = "nixpkgs-server";
    };
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-server.url = "github:NixOS/nixpkgs?rev=317484b1ead87b9c1b8ac5261a8d2dd748a0492d";
    conduit.url = "gitlab:famedly/conduit?ref=next";
    hyprland.url = "github:hyprwm/Hyprland";
    nix-gaming.url = "github:fufexan/nix-gaming";
    qbit.url = "github:nu-nu-ko/nixpkgs?ref=init-nixos-qbittorrent";
  };
  outputs = {
    nixpkgs,
    nixpkgs-server,
    ...
  } @ inputs: let
    importAll = path:
      builtins.filter (nixpkgs.lib.hasSuffix ".nix")
      (map toString (nixpkgs.lib.filesystem.listFilesRecursive path));
  in {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules =
          [./hosts/desktop.nix]
          ++ importAll ./lib
          ++ importAll ./modules/common
          ++ importAll ./modules/desktop;
      };
      nixserver = nixpkgs-server.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules =
          [./hosts/server.nix]
          ++ importAll ./lib
          ++ importAll ./modules/common
          ++ importAll ./modules/services;
      };
    };
  };
}
