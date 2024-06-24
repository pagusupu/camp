{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkDefault;
in
  mkIf (config.cute.theme.name == "rose-pine") {
    # https://rosepinetheme.com/palette/ingredients
    colours.base16 = rec {
      A1 = mkDefault "faf4ed"; # base
      A2 = mkDefault "fffaf3"; # surface
      A3 = mkDefault "f2e9de"; # overlay
      A4 = mkDefault "9893a5"; # muted
      A5 = mkDefault "797593"; # subtle
      A6 = mkDefault "575279"; # text
      A7 = A6;
      A8 = mkDefault "cecacd"; # highlight
      B1 = mkDefault "b4637a"; # love
      B2 = mkDefault "ea9d34"; # gold
      B3 = mkDefault "d7827e"; # rose
      B4 = mkDefault "286983"; # pine
      B5 = mkDefault "56949f"; # foam
      B6 = mkDefault "907aa9"; # iris
      B7 = B2;
      B8 = A8;
    };
    specialisation.dark.configuration = {
      colours.base16 = {
        A1 = "232136"; # base
        A2 = "2a273f"; # surface
        A3 = "393552"; # overlay
        A4 = "6e6a86"; # muted
        A5 = "908caa"; # subtle
        A6 = "e0def4"; # text
        A8 = "56526e"; # highlight
        B1 = "eb6f92"; # love
        B2 = "f6c177"; # gold
        B3 = "ea9a97"; # rose
        B4 = "3e8fb0"; # pine
        B5 = "9ccfd8"; # foam
        B6 = "c4a7e7"; # iris
      };
    };
  }
