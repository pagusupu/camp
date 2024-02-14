{
  config,
  lib,
  inputs,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];
  options.cute.home = {
    enable = lib.mkEnableOption "";
    git = lib.mkEnableOption "";
    ags = lib.mkEnableOption "";
  };
  config = let
    inherit (config.cute.home) enable git ags;
  in {
    home-manager = lib.mkIf enable {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = {inherit inputs;};
      users.pagu = {
        imports = [inputs.ags.homeManagerModules.default];
        home = {
          username = "pagu";
          homeDirectory = "/home/pagu";
          stateVersion = "23.05";
        };
        programs = {
          git = lib.mkIf git {
            enable = true;
            userName = "pagusupu";
            userEmail = "me@pagu.cafe";
          };
          ags = lib.mkIf ags {
            enable = true;
            configDir = ./ags;
          };
        };
      };
    };
  };
}
