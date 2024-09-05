{
  config,
  lib,
  _lib,
  ...
}: {
  options.cute.desktop.tofi = _lib.mkEnable;
  config = lib.mkIf config.cute.desktop.tofi {
    home-manager.users.pagu = {
      programs.tofi = {
        enable = true;
        settings = with config.colours.base16; {
          font-size = 16;
          width = 300;
          height = 500;
          corner-radius = 6;
          outline-width = 1;
          outline-color = "#${B4}";
          border-width = 0;
          padding-top = 10;
          padding-left = 15;
          prompt-text = ">>";
          prompt-padding = 10;
          background-color = "#${A1}";
          text-color = "#${A6}";
          selection-color = "#${A1}";
          selection-background = "#${B4}";
          selection-background-padding = 8;
          selection-background-corner-radius = 6;
          result-spacing = 20;
          terminal = "alacritty";
        };
      };
    };
  };
}
