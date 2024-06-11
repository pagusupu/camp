{
  config,
  lib,
  pkgs,
  ...
}: {
  options.cute.programs.gui.alacritty = lib.mkEnableOption "";
  config = lib.mkIf config.cute.programs.gui.alacritty {
    homefile."alacritty" = {
      target = ".config/alacritty/alacritty.toml";
      source = (pkgs.formats.toml {}).generate "alacritty.toml" {
        cursor = {
          style = "Underline";
          unfocused_hollow = false;
        };
        font = {
          size = 12;
          normal = {
            family = "monospace";
            style = "Regular";
          };
        };
        window = {
          dynamic_title = false;
          padding = {
            x = 10;
            y = 10;
          };
        };
        colors = let
          inherit (config.scheme) withHashtag;
          c = {
            white = withHashtag.base05;
            blue = withHashtag.base0C;
            red = withHashtag.base08;
            green = withHashtag.base0B;
            yellow = withHashtag.base09;
            magenta = withHashtag.base0D;
            cyan = withHashtag.base0A;
          };
        in {
          primary = {
            background = withHashtag.base00;
            foreground = c.white;
          };
          normal = c // {black = withHashtag.base00;};
          bright = c // {black = withHashtag.base03;};
          dim = c // {black = withHashtag.base03;};
        };
      };
    };
    environment.systemPackages = [
      pkgs.alacritty
      pkgs.ueberzugpp
    ];
  };
}
