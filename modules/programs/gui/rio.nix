{
  config,
  lib,
  pkgs,
  ...
}: {
  options.cute.programs.gui.rio = lib.mkEnableOption "";
  config = lib.mkIf config.cute.programs.gui.rio {
    homefile."rio" = {
      target = ".config/rio/config.toml";
      source = (pkgs.formats.toml {}).generate "config.toml" {
        confirm-before-quit = false;
        cursor = "_";
        editor = "nvim";
        padding-x = 10;
        fonts = {
          family = "monospace";
          extras = [{family = "NerdFontsSymbolsOnly";}];
        };
        navigation = {
          #mode = "TopTab";
          clickable = true;
        };
        renderer = {
          backend = "vulkan";
          performance = "high";
        };
        colours = let
          inherit (config.scheme) withHashtag;
        in {
          background = withHashtag.base00;
          foreground = withHashtag.base05;
          selection-background = withHashtag.base02;
          selection-foreground = withHashtag.base05;
          cursor = withHashtag.base05;
          tabs = withHashtag.base02;
          tabs-active = withHashtag.base03;

          black = withHashtag.base02;
          blue = withHashtag.base0C;
          cyan = withHashtag.base0A;
          green = withHashtag.base0B;
          magenta = withHashtag.base0D;
          red = withHashtag.base08;
          white = withHashtag.base05;
        };
      };
    };
    environment.systemPackages = [pkgs.rio];
  };
}
