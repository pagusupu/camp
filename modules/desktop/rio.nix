{
  config,
  lib,
  ...
}: {
  options.cute.desktop.rio = lib.mkEnableOption "";
  config = lib.mkIf config.cute.desktop.rio {
    home-manager.users.pagu = {
      programs.rio = {
        enable = true;
        settings = {
          confirm-before-quit = false;
          cursor = "_";
          editor = "nvim";
          padding-x = 10;
          working-dir = "/home/pagu/";
          window.mode = "Maximized";
          fonts = {
            size = 20;
            family = "MonaspiceNe Nerd Font";
            regular = {
              style = "normal";
              weight = 400;
            };
            bold = {
              style = "normal";
              weight = 800;
            };
            italic = {
              style = "italic";
              weight = 400;
            };
            bold-italic = {
              style = "italic";
              weight = 800;
            };
          };
          navigation = {
            mode = "CollapsedTab";
            clickable = true;
            use-current-path = false;
          };
          renderer = {
            performance = "High";
            backend = "Vulkan";
            disable-unfocused-render = false;
          };
          colors = let
            inherit (config.cute) colours;
          in {
            background = "#" + colours.base;
            foreground = "#" + colours.text;
            selection-background = "#" + colours.text;
            selection-foreground = "#" + colours.base;
            tabs = "#" + colours.muted;
            tabs-active = "#" + colours.iris;
            cursor = "#" + colours.text;
            vi-cursor = "#" + colours.text;
            black = "#" + colours.muted;
            red = "#" + colours.love;
            green = "#" + colours.pine;
            yellow = "#" + colours.gold;
            blue = "#" + colours.foam;
            magenta = "#" + colours.iris;
            cyan = "#" + colours.rose;
            white = "#" + colours.text;
            light-black = "#" + colours.muted;
            light-red = "#" + colours.love;
            light-green = "#" + colours.pine;
            light-yellow = "#" + colours.gold;
            light-blue = "#" + colours.foam;
            light-magenta = "#" + colours.iris;
            light-cyan = "#" + colours.rose;
            light-white = "#" + colours.text;
            dim-black = "#" + colours.muted;
            dim-red = "#" + colours.love;
            dim-green = "#" + colours.pine;
            dim-yellow = "#" + colours.gold;
            dim-blue = "#" + colours.foam;
            dim-magenta = "#" + colours.iris;
            dim-cyan = "#" + colours.rose;
            dim-white = "#" + colours.text;
          };
        };
      };
    };
  };
}
