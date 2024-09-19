{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.desktop.tofi = cutelib.mkEnable;
  config = lib.mkIf config.cute.desktop.tofi {
    assertions = cutelib.assertHm "tofi";
    home-manager.users.pagu = {
      programs.tofi = {
        enable = true;
        settings = with config.colours.base16; {
          font-size = 16;
          width = 360;
          height = 600;
          corner-radius = 6;
          outline-width = 1;
          outline-color = "#" + B1;
          border-width = 0;
          padding-top = 10;
          padding-left = 10;
          prompt-text = ">>";
          prompt-padding = 10;
          background-color = "#" + A1;
          text-color = "#" + A6;
          selection-color = "#" + A1;
          selection-background = "#" + B1;
          selection-background-padding = 8;
          selection-background-corner-radius = 6;
          result-spacing = 20;
          drun-launch = true;
          terminal = "alacritty";
        };
      };
    };
  };
}
