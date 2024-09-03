{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkDefault;
in
  mkIf (config.cute.theme.name == "everforest") {
    colours.base16 = rec {
      A1 = mkDefault "fdf6e3";
      A2 = mkDefault "f4f0d9";
      A3 = mkDefault "e6e2cc";
      A4 = mkDefault "939f91";
      A5 = "9da9a0";
      A6 = mkDefault "5c6a72";
      A7 = mkDefault "475258";
      A8 = mkDefault "2d353b";
      B1 = mkDefault "f85552";
      B2 = mkDefault "f57d26";
      B3 = mkDefault "dfa000";
      B4 = mkDefault "8da101";
      B5 = mkDefault "35a77c";
      B6 = mkDefault "3a94c5";
      B7 = mkDefault "df69ba";
      B8 = A4;
    };
    specialisation.dark.configuration = {
      colours.base16 = {
        A1 = "2d353b";
        A2 = "343f44";
        A3 = "475258";
        A4 = "859289";
        A6 = "d3c6aa";
        A7 = "e6e2cc";
        A8 = "fdf6e3";
        B1 = "e67e80";
        B2 = "e69875";
        B3 = "dbbc7f";
        B4 = "a7c080";
        B5 = "83c092";
        B6 = "7fbbb3";
        B7 = "d699b6";
      };
    };
  }
