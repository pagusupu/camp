{ 
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    hyprland.url = "github:hyprwm/Hyprland";
    alejandra.url = "github:kamadorueda/alejandra/3.0.0";
  };
  outputs = {
    nixpkgs,
    ...
  } @ inputs: {
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
         
                
