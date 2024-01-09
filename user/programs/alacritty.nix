{
  config,
  lib,
  ...
}: {
  options.hm.programs.alacritty.enable = lib.mkEnableOption "";
  config = lib.mkIf config.hm.programs.alacritty.enable {
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
            family = "MonaspiceNe Nerd Font";
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
            background = "#" + cute.base;
            foreground = "#" + cute.text;
            dim_foreground = "#" + cute.subtle;
            bright_foreground = "#" + cute.text;
          };
          normal = {
            black = "#" + cute.muted;
            red = "#" + cute.love;
            green = "#" + cute.pine;
            yellow = "#" + cute.gold;
            blue = "#" + cute.foam;
            magenta = "#" + cute.iris;
            cyan = "#" + cute.rose;
            white = "#" + cute.text;
          };
          bright = {
            black = "#" + cute.muted;
            red = "#" + cute.love;
            green = "#" + cute.pine;
            yellow = "#" + cute.gold;
            blue = "#" + cute.foam;
            magenta = "#" + cute.iris;
            cyan = "#" + cute.rose;
            white = "#" + cute.text;
          };
        };
      };
    };
  };
}
