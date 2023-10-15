{
  config,
  lib,
  ...
}: {
  options.cute.programs.dunst = {
    enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.cute.programs.dunst.enable {
    services.dunst = {
      enable = true;
      settings = {
        global = {
	  monitor = 1;
          width = 300;
          height = 160;
          origin = "top-left";
	  offset = "12x12";
	  padding = 2;
	  horizontal_padding = 10;
	  gap_size = 4;
          background = "#${config.cute.colours.primary.bg}";
          foreground = "#${config.cute.colours.primary.fg}";
          frame_color = "#${config.cute.colours.primary.main}";
	  frame-width = 1;
          font = "nunito 12";
	  notification_limit = 2;
        };
      };
    };
  };
}
