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
    themes.firefox = lib.mkEnableOption "";
  };
  config = let
    inherit (config.cute.home) enable ags;
    inherit (config.cute.home.themes) firefox;
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
          file = {
            "firefox" = lib.mkIf firefox {
              source = ./themes/firefox.css;
              target = ".mozilla/firefox/pagu/chrome/userChrome.css";
            };
          };
        };
        imports = lib.mkIf ags [inputs.ags.homeManagerModules.default];
        programs = {
          ags = lib.mkIf ags {
            enable = true;
            configDir = ./ags;
          };
        };
      };
    };
  };
}
