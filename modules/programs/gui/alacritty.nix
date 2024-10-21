{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}: {
  options.cute.programs.gui.alacritty = cutelib.mkEnable;
  config = lib.mkIf config.cute.programs.gui.alacritty {
    assertions = cutelib.assertHm "alacritty";
    home-manager.users.pagu = {
      programs.alacritty = {
        enable = true;
        settings = {
          cursor = {
            style = "Underline";
            unfocused_hollow = false;
          };
          font = {
            normal = {
              family = "monospace";
              style = "Regular";
            };
            size = 12;
          };
          window = {
            padding = {
              x = 10;
              y = 10;
            };
            dynamic_title = false;
          };
          colors = with config.wh.colours; let
            c = {
              white = text;
              blue = foam;
              red = love;
              green = pine;
              yellow = gold;
              magenta = iris;
              cyan = rose;
            };
          in {
            primary = {
              background = base;
              foreground = text;
            };
            normal = c // {black = base;};
            bright = c // {black = muted;};
            dim = c // {black = muted;};
          };
        };
      };
      home.packages = [pkgs.ueberzugpp];
    };
  };
}
