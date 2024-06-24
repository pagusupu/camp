{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkDefault;
in
  mkIf (config.cute.theme.name == "rose-pine") {
    colours.base16 = rec {
      A1 = mkDefault "faf4ed";
      A2 = mkDefault "fffaf3";
      A3 = mkDefault "f2e9de";
      A4 = mkDefault "9893a5";
      A5 = mkDefault "797593";
      A6 = mkDefault "575279";
      A7 = A6;
      A8 = mkDefault "cecacd";
      B1 = mkDefault "b4637a";
      B2 = mkDefault "ea9d34";
      B3 = mkDefault "d7827e";
      B4 = mkDefault "286983";
      B5 = mkDefault "56949f";
      B6 = mkDefault "907aa9";
      B7 = B2;
      B8 = A8;
    };
    specialisation.dark.configuration = {
      colours.base16 = {
        A1 = "232136";
        A2 = "2a273f";
        A3 = "393552";
        A4 = "6e6a86";
        A5 = "908caa";
        A6 = "e0def4";
        A8 = "56526e";
        B1 = "eb6f92";
        B2 = "f6c177";
        B3 = "ea9a97";
        B4 = "3e8fb0";
        B5 = "9ccfd8";
        B6 = "c4a7e7";
      };
    };
  }
