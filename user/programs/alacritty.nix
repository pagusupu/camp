{
  config,
  lib,
  ...
}: {
  options.cute.programs.alacritty = {
    enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.cute.programs.alacritty.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        window = {
          padding = {
            x = 10;
            y = 10;
          };
        };
        font = {
          size = 12;
          normal = {
            family = "SF Mono";
            style = "Regular";
          };
        };
        cursor = {
          style = "Underline";
          unfocused_hollow = false;
        };
        colors = {
          primary = {
            background = "#" + config.cute.colours.primary.bg;
            foreground = "#" + config.cute.colours.primary.fg;
            dim_foreground = "#" + config.cute.colours.normal.black;
            bright_foreground = "#" + config.cute.colours.bright.black;
          };
          normal = {
            black = "#" + config.cute.colours.normal.black;
            red = "#" + config.cute.colours.normal.red;
            green = "#" + config.cute.colours.normal.green;
            yellow = "#" + config.cute.colours.normal.yellow;
            blue = "#" + config.cute.colours.normal.blue;
            magenta = "#" + config.cute.colours.normal.magenta;
            cyan = "#" + config.cute.colours.normal.cyan;
            white = "#" + config.cute.colours.normal.white;
          };
          bright = {
            black = "#" + config.cute.colours.bright.black;
            red = "#" + config.cute.colours.bright.red;
            green = "#" + config.cute.colours.bright.green;
            yellow = "#" + config.cute.colours.bright.yellow;
            blue = "#" + config.cute.colours.bright.blue;
            magenta = "#" + config.cute.colours.bright.magenta;
            cyan = "#" + config.cute.colours.bright.cyan;
            white = "#" + config.cute.colours.bright.white;
          };
        };
      };
    };
  };
}
