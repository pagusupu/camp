{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.desktop.hypr.paper = cutelib.mkEnable;
  config = let
    m1 = "DP-3";
    m2 = "HDMI-A-1";
    p = "~/camp/modules/themes/${config.cute.theme.name}/wallpapers";
  in
    lib.mkIf config.cute.desktop.hypr.paper (lib.mkMerge [
      {
        assertions = cutelib.assertHm "hyprpaper";
        home-manager.users.pagu = {
          services.hyprpaper = {
            enable = true;
            settings = {
              preload = [
                "${p}/left.png"
                "${p}/right.png"
              ];
              wallpaper = [
                "${m1}, ${p}/left.png"
                "${m2}, ${p}/right.png"
              ];
            };
          };
        };
      }
      (lib.mkIf config.cute.desktop.hypr.land {
        home-manager.users.pagu = {
          wayland.windowManager.hyprland.settings.exec = [
            "hyprctl hyprpaper unload all"
            ''hyprctl hyprpaper preload "${p}/left.png"''
            ''hyprctl hyprpaper preload "${p}/right.png"''
            ''hyprctl hyprpaper wallpaper "${m1},${p}/left.png"''
            ''hyprctl hyprpaper wallpaper "${m2},${p}/right.png"''
          ];
        };
      })
    ]);
}
