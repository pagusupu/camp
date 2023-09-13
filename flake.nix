{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
  };
  outputs = {nixpkgs, ...} @ inputs: {
    nixosConfigurations = {
      home = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/home
          inputs.home-manager.nixosModules.home-manager
        ];
      };
    };
  };
}
