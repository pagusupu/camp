{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
    nh.url = "github:viperML/nh";
    nix-index-database.url = "github:Mic92/nix-index-database";
    nixvim.url = "github:nix-community/nixvim";
  };
  outputs = {nixpkgs, ...} @ inputs: {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/desktop
          inputs.home-manager.nixosModules.home-manager
          inputs.nh.nixosModules.default
        ];
      };
    };
  };
}
