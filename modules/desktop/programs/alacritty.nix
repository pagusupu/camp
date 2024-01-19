{
  config,
  lib,
  ...
}: {
  options.cute.desktop.programs.alacritty = lib.mkEnableOption "";
  config = lib.mkIf config.cute.desktop.programs.alacritty {
    home-manager.users.pagu = {
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
            inherit (config.cute) colours;
          in {
            primary = {
              background = "#" + colours.base;
              foreground = "#" + colours.text;
              dim_foreground = "#" + colours.subtle;
              bright_foreground = "#" + colours.text;
            };
            normal = {
              black = "#" + colours.muted;
              red = "#" + colours.love;
              green = "#" + colours.pine;
              yellow = "#" + colours.gold;
              blue = "#" + colours.foam;
              magenta = "#" + colours.iris;
              cyan = "#" + colours.rose;
              white = "#" + colours.text;
            };
            bright = {
              black = "#" + colours.muted;
              red = "#" + colours.love;
              green = "#" + colours.pine;
              yellow = "#" + colours.gold;
              blue = "#" + colours.foam;
              magenta = "#" + colours.iris;
              cyan = "#" + colours.rose;
              white = "#" + colours.text;
            };
          };
        };
      };
    };
  };
}
