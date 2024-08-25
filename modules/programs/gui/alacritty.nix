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
          normal = {
            family = "monospace";
            style = "Regular";
          };
          size = 12;
        };
        window = {
          padding = {
            x = 10;
            y = 10;
          };
          dynamic_title = false;
        };
        colors = with config.colours.base16; let
          c = {
            white = "#" + A6;
            blue = "#" + B5;
            red = "#" + B1;
            green = "#" + B4;
            yellow = "#" + B2;
            magenta = "#" + B6;
            cyan = "#" + B3;
          };
        in {
          primary = {
            background = "#" + A1;
            foreground = "#" + A6;
          };
          normal = c // {black = "#" + A1;};
          bright = c // {black = "#" + A4;};
          dim = c // {black = "#" + A4;};
        };
      };
    };
    environment.systemPackages = with pkgs; [
      alacritty
      ueberzugpp
    ];
  };
}
