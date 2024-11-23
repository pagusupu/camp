{
  config,
  lib,
  cutelib,
  inputs,
  ...
}: {
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  options.cute.services.backend.home-manager = cutelib.mkEnable;
  config = lib.mkIf config.cute.services.backend.home-manager {
    home-manager = {
      users.pagu.home = rec {
        homeDirectory = "/home/${username}";
        username = "pagu";
      };
      extraSpecialArgs.inputs = inputs;
      useGlobalPkgs = true;
      useUserPackages = true;
    };
  };
}
