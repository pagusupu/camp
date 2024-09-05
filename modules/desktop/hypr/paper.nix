{
  config,
  lib,
  _lib,
  ...
}: {
  options.cute.desktop.hypr.paper = _lib.mkEnable;
  config = lib.mkIf config.cute.desktop.hypr.paper {
    assertions = _lib.assertHm "hyprpaper";
    home-manager.users.pagu = {
      services.hyprpaper = {
        enable = true;
        settings = let
          m1 = "DP-3";
          m2 = "HDMI-A-1";
          p = "~/camp/modules/themes/${config.cute.theme.name}/wallpapers";
        in {
          preload = [
            "${p}/light-left"
            "${p}/light-right"
          ];
          wallpaper = [
            "${m1}, ${p}/light-left"
            "${m2}, ${p}/light-right"
          ];
        };
      };
    };
  };
}
