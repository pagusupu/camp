{
  config,
  lib,
  cutelib,
  ...
}: let
  inherit (lib) mkOption types mkMerge mkDefault mkIf;
  inherit (config.cute) dark;
in {
  options = let
    str = mkOption { type = types.str; };
  in rec {
    colours = {
      base = str;
      surface = str;
      overlay = str;
      muted = str;
      subtle = str;
      text = str;
      highlight = str;
      love = str;
      gold = str;
      rose = str;
      pine = str;
      foam = str;
      iris = str;
      wallpaper = str;
    };
    wh.colours = colours;
    cute.dark = cutelib.mkEnable;
  };
  config = mkMerge [
    {
      colours = {
        base = mkDefault "faf4ed";
        surface = mkDefault "fffaf3";
        overlay = mkDefault "f2e9de";
        muted = mkDefault "9893a5";
        subtle = mkDefault "797593";
        text = mkDefault "575279";
        highlight = mkDefault "cecacd";
        love = mkDefault "b4637a";
        gold = mkDefault "ea9d34";
        rose = mkDefault "d7827e";
        pine = mkDefault "286983";
        foam = mkDefault "56949f";
        iris = mkDefault "907aa9";
      };
      wh.colours = with config.colours; {
        base = "#" + base;
        surface = "#" + surface;
        overlay = "#" + overlay;
        muted = "#" + muted;
        subtle = "#" + subtle;
        text = "#" + text;
        highlight = "#" + highlight;
        love = "#" + love;
        gold = "#" + gold;
        rose = "#" + rose;
        pine = "#" + pine;
        foam = "#" + foam;
        iris = "#" + iris;
      };
    }
    (mkIf dark {
      specialisation.dark.configuration = {
        colours = {
          base = "191724";
          surface = "1f1d2e";
          overlay = "26233a";
          muted = "6e6a86";
          subtle = "908caa";
          text = "e0def4";
          highlight = "524f67";
          love = "eb6f92";
          gold = "f6c177";
          rose = "ea9a97";
          pine = "3e8fb0";
          foam = "9ccfd8";
          iris = "c4a7e7";
        };
      };
    })
    (mkIf dark {
      specialisation.dark.configuration = {
        boot.loader.grub.configurationName = "dark";
        environment.etc."specialisation".text = "dark";
      };
    })
  ];
}
