{
  config,
  lib,
  cutelib,
  inputs,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];
  options.cute.services.backend.home-manager = cutelib.mkEnable;
  config = lib.mkIf config.cute.services.backend.home-manager {
    home-manager = {
      users.pagu.home = {
        username = "pagu";
        homeDirectory = "/home/pagu";
        stateVersion = "23.05";
      };
      extraSpecialArgs = {inherit inputs;};
      useGlobalPkgs = true;
      useUserPackages = true;
    };
  };
}
