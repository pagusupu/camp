{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkDefault;
  inherit (config.cute.common) nixvim;
in {
  programs.nixvim.colorschemes.rose-pine = mkIf nixvim {
    style = mkDefault "dawn";
  };
  specialisation.dark.configuration = {
    programs.nixvim.colorschemes.rose-pine = mkIf nixvim {
      style = mkDefault "dawn";
    };
  };
}
