{
  inputs = {
    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        darwin.follows = "";
        home-manager.follows = "";
      };
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mountain = {
      url = "github:nu-nu-ko/mountain-nix";
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
    nixos-mailserver,
    ...
  } @ inputs: let
    importAll = path:
    # recursive import so no default.nix spam. from https://github.com/nu-nu-ko/crystal/blob/main/flake.nix
      builtins.filter (nixpkgs.lib.hasSuffix ".nix")
      (map toString (nixpkgs.lib.filesystem.listFilesRecursive path));
  in {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules =
          [
            ./hosts/desktop
            inputs.home-manager.nixosModules.home-manager
            agenix.nixosModules.default
            nh.nixosModules.default
          ]
          ++ importAll ./libs
          ++ importAll ./user
          ++ importAll ./system;
      };
      nixserver = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules =
          [
            ./hosts/server.nix
            agenix.nixosModules.default
            nh.nixosModules.default
	    nixos-mailserver.nixosModules.default
          ]
          ++ importAll ./libs
          ++ importAll ./system;
      };
    };
  };
}
