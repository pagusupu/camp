{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    hyprland.url = "github:hyprwm/Hyprland";
    nix-gaming.url = "github:fufexan/nix-gaming";
    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        darwin.follows = "";
        home-manager.follows = "";
      };
    };
    conduit = {
      url = "gitlab:famedly/conduit";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nh = {
      url = "github:viperML/nh";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-mailserver = {
      url = "gitlab:simple-nixos-mailserver/nixos-mailserver";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
  outputs = {
    nixpkgs,
    home-manager,
    agenix,
    nh,
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
          [
            ./hosts/desktop.nix
            inputs.home-manager.nixosModules.home-manager
            agenix.nixosModules.default
            nh.nixosModules.default
          ]
          ++ importAll ./libs
          ++ importAll ./system
	  ++ importAll ./user;
      };
      nixserver = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules =
          [
            ./hosts/server.nix
            agenix.nixosModules.default
            nh.nixosModules.default
          ]
          ++ importAll ./libs
          ++ importAll ./system;
      };
    };
  };
}
