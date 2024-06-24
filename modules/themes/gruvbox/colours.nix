{
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkDefault;
in
  mkIf (config.cute.theme.name == "gruvbox") {
    colours.base16 = {
      A1 = mkDefault "f9f5d7";
      A2 = mkDefault "ebdbb2";
      A3 = mkDefault "d5c4a1";
      A4 = mkDefault "bdae93";
      A5 = mkDefault "665c54";
      A6 = mkDefault "504945";
      A7 = mkDefault "3c3836";
      A8 = mkDefault "282828";
      B1 = mkDefault "9d0006";
      B2 = mkDefault "af3a03";
      B3 = mkDefault "b57614";
      B4 = mkDefault "79740e";
      B5 = mkDefault "427b58";
      B6 = mkDefault "076678";
      B7 = mkDefault "8f3f71";
      B8 = mkDefault "d65d0e";
    };
    specialisation.dark.configuration = {
      colours.base16 = {
        A1 = "1d2021";
        A2 = "3c3836";
        A3 = "504945";
        A4 = "665c54";
        A5 = "bdae93";
        A6 = "d5c4a1";
        A7 = "ebdbb2";
        A8 = "fbf1c7";
        B1 = "fb4934";
        B2 = "fe8019";
        B3 = "fabd2f";
        B4 = "b8bb26";
        B5 = "8ec07c";
        B6 = "83a598";
        B7 = "d3869b";
        B8 = "d65d0e";
      };
    };
  }
