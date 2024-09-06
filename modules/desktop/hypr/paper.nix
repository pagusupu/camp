{
  config,
  lib,
  _lib,
  ...
}: {
  options.cute.desktop.hypr.paper = _lib.mkEnable;
  config = let
    m1 = "DP-3";
    m2 = "HDMI-A-1";
    p = "~/camp/modules/themes/${config.cute.theme.name}/wallpapers";
  in
    lib.mkIf config.cute.desktop.hypr.paper {
      assertions = _lib.assertHm "hyprpaper";
      home-manager.users.pagu = {
        services.hyprpaper = {
          enable = true;
          settings = {
            preload = [
              "${p}/left.png"
              "${p}/right.png"
            ];
            wallpaper = lib.mkDefault [
              "${m1}, ${p}/left.png"
              "${m2}, ${p}/right.png"
            ];
          };
        };
      };
    };
}
