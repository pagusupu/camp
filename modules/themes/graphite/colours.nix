{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkDefault;
in
  mkIf (config.cute.theme.name == "graphite") {
    colours.base16 = {
      A1 = mkDefault "ffffff";
      A2 = mkDefault "e3e3e3";
      A3 = mkDefault "b9b9b9";
      A4 = mkDefault "ababab";
      A5 = mkDefault "525252";
      A6 = mkDefault "464646";
      A7 = mkDefault "252525";
      A8 = mkDefault "101010";
      B1 = mkDefault "7c7c7c";
      B2 = mkDefault "999999";
      B3 = mkDefault "a0a0a0";
      B4 = mkDefault "8e8e8e";
      B5 = mkDefault "868686";
      B6 = mkDefault "686868";
      B7 = mkDefault "747474";
      B8 = mkDefault "5e5e5e";
    };
    specialisation.dark.configuration = {
      colours.base16 = {
        A1 = "2c2c2c";
        A2 = "252525";
        A3 = "464646";
        A4 = "525252";
        A5 = "ababab";
        A6 = "b9b9b9";
        A7 = "e3e3e3";
        A8 = "f7f7f7";
        #B1 = "7c7c7c";
        #B2 = "999999";
        #B3 = "a0a0a0";
        #B4 = "8e8e8e";
        B5 = "686868";
        B6 = "c4a7e7";
        #B7 = "747474";
        #B8 = "5e5e5e";
      };
    };
  }
