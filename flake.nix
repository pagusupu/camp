{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    nix-index-database.url = "github:Mic92/nix-index-database";
    nh.url = "github:viperML/nh";
    nixvim.url = "github:nix-community/nixvim";
  };
  outputs = {nixpkgs, ...} @ inputs: {
    nixosConfigurations = {
      desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/home
          inputs.home-manager.nixosModules.home-manager
          inputs.nh.nixosModules.default
        ];
      };
    };
  };
}
