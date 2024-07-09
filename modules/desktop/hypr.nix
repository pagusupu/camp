{
  config,
  lib,
  _lib,
  ...
}: let
  inherit (lib) mkEnableOption mkMerge mkIf;
in {
  options.cute.desktop.hypr = {
    idle = mkEnableOption "";
    lock = mkEnableOption "";
  };
  config = let
    inherit (config.cute.desktop.hypr) idle lock;
  in
    mkMerge [
      (mkIf idle {
        assertions = _lib.assertHm "hypridle";
        home-manager.users.pagu.services.hypridle = {
          enable = true;
          settings = {
            general = {
              lock_cmd = "pidof hyprlock || hyprlock";
              before_sleep_cmd = "loginctl lock-session";
              after_sleep_cmd = "hyprctl dispatch dpms on";
            };
            listener = [
              {
                timeout = 300;
                on-timeout = "loginctl lock-session";
              }
              {
                timeout = 600;
                on-timeout = "hyprctl dispatch dpms off";
                on-resume = "hyprctl dispatch dpms on";
              }
              {
                timeout = 900;
                on-timeout = "systemctl suspend";
              }
            ];
          };
        };
      })
      (mkIf lock {
        assertions = _lib.assertHm "hyprlock";
        home-manager.users.pagu.programs.hyprlock = {
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
      })
    ];
}
