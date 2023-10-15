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
          fg = mkLiteral "#${config.cute.colours.normal.white}";
          bg = mkLiteral "#${config.cute.colours.primary.bg}";
          bg2 = mkLiteral "#${config.cute.colours.normal.black}";
          accent = mkLiteral "#${config.cute.colours.primary.main}";
          text-color = mkLiteral "@fg";
          margin = 0;
          padding = 0;
          spacing = 0;
        };
        window = {
          width = 350;
          border = mkLiteral "2px";
          border-color = mkLiteral "@accent";
        };
        textbox = {
          background-color = mkLiteral "@bg";
        };
        listview = {
          lines = 6;
	  padding = mkLiteral "8px";
	  spacing = mkLiteral "8px";
          cursor = mkLiteral "pointer";
          background-color = mkLiteral "@bg";
        };
        inputbar = {
          spacing = mkLiteral "8px";
          background-color = mkLiteral "@bg";
        };
        entry = {
          padding = mkLiteral "12px 0px 0px 0px";
        };
        prompt = {
	  margin = mkLiteral "8px 0px 0px 8px";
          padding = mkLiteral "4px 10px 4px 10px";
          background-color = mkLiteral "@bg2";
          text-color = mkLiteral "@accent";
        };
        element = {
          padding = mkLiteral "8px";
          background-color = mkLiteral "@bg2";
        };
        element-text = {
          text-color = mkLiteral "inherit";
        };
	"element selected" = {
	  background-color = mkLiteral "@accent";
	  text-color = mkLiteral "@bg";
	};
      };
    };
  };
}
