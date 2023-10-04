{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    nix-index-database.url = "github:Mic92/nix-index-database";
    nixvim.url = "github:nix-community/nixvim";
    nh.url = "github:viperML/nh";
    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
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
