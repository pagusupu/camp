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
        colors = let 
	  cute = config.cute.colours; 
	in {
          primary = {
            background = "#" + cute.primary.bg;
            foreground = "#" + cute.primary.fg;
            dim_foreground = "#" + cute.normal.black;
            bright_foreground = "#" + cute.bright.black;
          };
          normal = {
            black = "#" + cute.normal.black;
            red = "#" + cute.normal.red;
            green = "#" + cute.normal.green;
            yellow = "#" + cute.normal.yellow;
            blue = "#" + cute.normal.blue;
            magenta = "#" + cute.normal.magenta;
            cyan = "#" + cute.normal.cyan;
            white = "#" + cute.normal.white;
          };
          bright = {
            black = "#" + cute.bright.black;
            red = "#" + cute.bright.red;
            green = "#" + cute.bright.green;
            yellow = "#" + cute.bright.yellow;
            blue = "#" + cute.bright.blue;
            magenta = "#" + cute.bright.magenta;
            cyan = "#" + cute.bright.cyan;
            white = "#" + cute.bright.white;
          };
        };
      };
    };
  };
}
