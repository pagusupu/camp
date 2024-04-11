{
  config,
  lib,
  inputs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    inputs.base16.nixosModule
  ];
  options.cute.themes = {
    enable = mkEnableOption "";
    rose-pine = mkEnableOption "";
  };
  config = mkIf config.cute.themes.enable {
    home-manager = {
      useGlobalPkgs = true;
      useUserPackages = true;
      extraSpecialArgs = {inherit inputs;};
      users.pagu = {
        home = {
          username = "pagu";
          homeDirectory = "/home/pagu";
          stateVersion = "23.05";
        };
        qt = {
          enable = true;
          platformTheme = "gtk";
        };
      };
    };
    programs.dconf.enable = true;
  };
}
