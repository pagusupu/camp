{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}:
lib.mkIf (config.cute.desktop.de == "hyprland")
(lib.mkMerge [
  {
    assertions = cutelib.assertHm "hyprland-style";
    home-manager.users.pagu = {
      wayland.windowManager.hyprland = lib.mkMerge [
        {
          settings.exec = let
            inherit (config.home-manager.users.pagu.home.pointerCursor) name size;
          in [ "hyprctl setcursor ${name} ${builtins.toString size}" ];
        }
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
            misc = {
              animate_manual_resizes = true;
              disable_hyprland_logo = true;
            };
            exec-once = [ "rwpspread -b swaybg -i ~/pictures/active/bg.png" ];
          };
        }
      ];
      home.packages = with pkgs; [ rwpspread swaybg ];
    };
  }
])
