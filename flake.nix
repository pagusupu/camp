{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
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
          inputs.nixvim.homeManagerModules.nixvim
        ];
      };
    };
  };
}
