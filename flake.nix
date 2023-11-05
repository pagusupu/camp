{
  inputs = {
    agenix.url = "github:ryantm/agenix";
    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
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
    ...
  } @ inputs: {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/desktop
          agenix.nixosModules.default
          inputs.home-manager.nixosModules.home-manager
        ];
      };
      server = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/server
          agenix.nixosModules.default
        ];
      };
    };
    formatter.x86_64-linux = inputs.nixpkgs.legacyPackages.x86_64-linux.alejandra;
  };
}
