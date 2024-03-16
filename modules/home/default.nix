{
  config,
  lib,
  inputs,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];
  options.cute.home = {
    enable = lib.mkEnableOption "";
    ags = lib.mkEnableOption "";
  };
  config = let
    inherit (config.cute.home) enable ags;
  in {
    home-manager = lib.mkIf enable {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = {inherit inputs;};
      users.pagu = {
        home = {
          username = "pagu";
          homeDirectory = "/home/pagu";
          stateVersion = "23.05";
        };
        imports = [inputs.ags.homeManagerModules.default];
        programs = {
          ags = lib.mkIf ags {
            enable = true;
            configDir = ../ags;
          };
        };
      };
    };
    _module.args.images = {
      bg = images/bg.jpg;
      lock = images/lockbg.png;
    };
  };
}
