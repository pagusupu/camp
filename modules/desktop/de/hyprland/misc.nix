{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}:
lib.mkIf (config.cute.desktop.de == "hyprland") {
  assertions = cutelib.assertHm "hyprland-style";
  home-manager.users.pagu = {
    wayland.windowManager.hyprland = let
      inherit (config.cute.desktop.monitors) m1 m2;
    in
      lib.mkMerge [
        # cursor
        {
          settings = {
            exec = let
              inherit (config.home-manager.users.pagu.home.pointerCursor) name size;
            in ["hyprctl setcursor ${name} ${builtins.toString size}"];
            cursor = {
              default_monitor = m1;
              no_hardware_cursors = true;
            };
            input = {
              accel_profile = "flat";
              follow_mouse = 2;
              sensitivity = "-0.1";
            };
          };
        }
        # misc
        {
          settings = {
            animations = {
              enabled = true;
              animation = [
                "windows, 1, 2, default"
                "border, 1, 2, default"
                "fade, 1, 2, default"
                "workspaces, 1, 1, default, slidevert"
              ];
              first_launch_animation = false;
            };
            decoration = {
              blur.enabled = false;
              rounding = 6;
            };
            general = {
              border_size = 3;
              gaps_in = 3;
              gaps_out = 6;
              hover_icon_on_border = false;
              resize_on_border = true;
              "col.active_border" = "0xFF" + config.colours.iris;
              "col.inactive_border" = "0xFF" + config.colours.overlay;
            };
            misc.animate_manual_resizes = true;
          };
        }
        # wallpaper
        (let
          inherit (config.cute.desktop) theme wallpaper-colour;
          wallpaper = ''swaybg -o ${m1} -i ~/pictures/active/${theme}.png -m fill -o ${m2} -c ${wallpaper-colour}'';
        in {
          settings = {
            exec = [
              "kill $(pidof swaybg)"
              "${wallpaper}"
            ];
            exec-once = ["${wallpaper}"];
            misc.disable_hyprland_logo = true;
          };
        })
      ];
    home.packages = [pkgs.swaybg];
  };
}
