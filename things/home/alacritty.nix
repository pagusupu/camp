{
  mcolours,
  config,
  lib,
  ...
}: {
  imports = [../misc/colours.nix];
  options.local.programs.alacritty = {
    enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.local.programs.alacritty.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        window = {
          opacity = 1;
          padding = {
            x = 10;
            y = 10;
          };
          dynamic_title = true;
        };
        font = {
          size = 12;
          normal = {
            family = "firacode";
            style = "Regular";
          };
        };
        cursor = {
          style = "Underline";
          unfocused_hollow = false;
        };
        colors = {
          primary = {
            background = "#" + mcolours.primary.bg;
            foreground = "#" + mcolours.primary.fg;
            dim_foreground = "#" + mcolours.normal.black;
            bright_foreground = "#" + mcolours.bright.black;
          };
          normal = {
            black = "#" + mcolours.normal.black;
            red = "#" + mcolours.normal.red;
            green = "#" + mcolours.normal.green;
            yellow = "#" + mcolours.normal.yellow;
            blue = "#" + mcolours.normal.blue;
            magenta = "#" + mcolours.normal.magenta;
            cyan = "#" + mcolours.normal.cyan;
            white = "#" + mcolours.normal.white;
          };
          bright = {
            black = "#" + mcolours.bright.black;
            red = "#" + mcolours.bright.red;
            green = "#" + mcolours.bright.green;
            yellow = "#" + mcolours.bright.yellow;
            blue = "#" + mcolours.bright.blue;
            magenta = "#" + mcolours.bright.magenta;
            cyan = "#" + mcolours.bright.cyan;
            white = "#" + mcolours.bright.white;
          };
        };
      };
    };
  };
}
