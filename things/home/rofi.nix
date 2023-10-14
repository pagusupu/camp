{
  lib,
  config,
  ...
}: {
  options.cute.programs.rofi = {
    enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.cute.programs.rofi.enable {
    programs.rofi = {
      enable = true;
      terminal = "alacritty";
      font = "firacode nerd font 12";
      extraConfig = {
	display-drun = ">";
      };
      theme = let
        inherit (config.lib.formats.rasi) mkLiteral;
      in {
        "*" = {
          background-color = mkLiteral "transparent";
          fg = mkLiteral "#${config.cute.colours.primary.fg}";
          bg = mkLiteral "#${config.cute.colours.primary.bg}";
          bg2 = mkLiteral "#${config.cute.colours.normal.black}";
          accent = mkLiteral "#${config.cute.colours.primary.main}";
          text-color = mkLiteral "@fg";
          margin = 0;
          padding = 0;
          spacing = 0;
        };
        window = {
          location = mkLiteral "center";
          width = 480;
          height = 40;
          border = mkLiteral "2px";
          border-color = mkLiteral "@accent";
        };
        textbox = {
          background-color = mkLiteral "@bg";
        };
        mainbox = {
          orientation = mkLiteral "horizontal";
        };
        listview = {
          lines = 1;
          layout = mkLiteral "horizontal";
          fixed-height = false;
          require-input = true;
          cursor = mkLiteral "pointer";
          background-color = mkLiteral "@accent";
        };
        inputbar = {
          spacing = mkLiteral "8px";
          background-color = mkLiteral "@bg";
        };
        entry = {
          padding = mkLiteral "8px 0px 0px 0px";
        };
        prompt = {
          padding = mkLiteral "8px 14px 4px 14px";
          background-color = mkLiteral "@bg2";
          text-color = mkLiteral "@accent";
          width = 220;
        };
        element = {
          padding = mkLiteral "8px";
          background-color = mkLiteral "@accent";
        };
        element-text = {
          text-color = mkLiteral "@bg";
        };
      };
    };
  };
}
