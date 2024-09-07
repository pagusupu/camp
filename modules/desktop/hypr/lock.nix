{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.desktop.hypr.lock = cutelib.mkEnable;
  config = lib.mkIf config.cute.desktop.hypr.lock {
    assertions = cutelib.assertHm "hyprlock";
    home-manager.users.pagu = {
      programs.hyprlock = {
        enable = true;
        settings = {
          general = {
            hide_cursor = true;
            disable_loading_bar = true;
          };
          background = {
            monitor = "";
            path = "screenshot";
            blur_size = 10;
            blur_passes = 4;
          };
          input-field = with config.colours.base16; {
            monitor = "DP-3";
            size = "200, 50";
            position = "0, -20";
            halign = "center";
            valign = "center";
            fade_on_empty = false;
            outline_thickness = 3;
            outer_color = "0xFF" + B6;
            inner_color = "0xFF" + A1;
            font_color = "0xFF" + A6;
            check_color = "0xFF" + B4;
            fail_color = "0xFF" + B1;
            capslock_color = "0xFF" + B3;
            placeholder_text = "";
          };
        };
      };
    };
  };
}
