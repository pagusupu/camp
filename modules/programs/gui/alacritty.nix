{
  config,
  lib,
  pkgs,
  ...
}: {
  options.cute.programs.gui.alacritty = lib.mkEnableOption "";
  config = lib.mkIf config.cute.programs.gui.alacritty {
    home.file."alacritty" = {
      target = ".config/alacritty/alacritty.toml";
      source = (pkgs.formats.toml {}).generate "alacritty.toml" {
        cursor = {
          style = "Underline";
          unfocused_hollow = false;
        };
        font = {
          size = 12;
          normal = {
            family = "MonaspiceNe Nerd Font";
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
          inherit (config) scheme;
          default = {
            white = "#${scheme.base05}";
            blue = "#${scheme.base0C}";
            red = "#${scheme.base08}";
            green = "#${scheme.base0B}";
            yellow = "#${scheme.base09}";
            magenta = "#${scheme.base0D}";
            cyan = "#${scheme.base0A}";
          };
        in {
          primary = {
            background = "#${scheme.base00}";
            foreground = "#${scheme.base05}";
          };
          normal = default // {black = "#${scheme.base00}";};
          bright = default // {black = "#${scheme.base03}";};
          dim = default // {black = "#${scheme.base03}";};
        };
      };
    };
    environment.systemPackages = [pkgs.alacritty];
  };
}
