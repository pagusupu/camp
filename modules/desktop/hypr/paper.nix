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
              "${p}/light-left"
              "${p}/light-right"
              "${p}/dark-left"
              "${p}/dark-right"
            ];
            wallpaper = lib.mkDefault [
              "${m1}, ${p}/light-left"
              "${m2}, ${p}/light-right"
            ];
          };
        };
      };
      specialisation.dark.configuration = {
        home-manager.users.pagu = {
          services.hyprpaper.settings.wallpaper = [
            "${m1}, ${p}/dark-left"
            "${m2}, ${p}/dark-right"
          ];
        };
      };
    };
}
