{
  config,
  lib,
  _lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkMerge mkIf getExe;
  inherit (_lib) assertHm;
in {
  options.cute.desktop.hypr = {
    idle = mkEnableOption "";
    land = mkEnableOption "";
    lock = mkEnableOption "";
    paper = mkEnableOption "";
  };
  config = let
    inherit (config.cute.desktop.hypr) land idle lock paper;
    m1 = "DP-3";
    m2 = "HDMI-A-1";
    mod = "SUPER";
  in
    mkMerge [
      (mkIf land {
        assertions = assertHm "hyprland";
        home-manager.users.pagu = {
          home.packages = with pkgs; [
            rwpspread
            satty
            swaybg
            wayland-pipewire-idle-inhibit
            wl-clipboard
          ];
          wayland.windowManager.hyprland = {
            enable = true;
            settings = {
              exec-once = [
                "rwpspread -b swaybg -i ~/pictures/active/bg.jpg"
                "waybar"
                "mako"
                "wayland-pipewire-idle-inhibit"
                "steam -console -silent"
              ];
              exec = let
                inherit (config.home-manager.users.pagu.home.pointerCursor) name size;
              in [
                "hyprctl setcursor ${name} ${builtins.toString size}"
              ];
              env = [
                "NIXOS_OZONE_WL,1"
                "_JAVA_AWT_WM_NONREPARENTING,1"
              ];
              windowrulev2 = [
                "float, class:(localsend_app)"
                "float, class:(com.saivert.pwvucontrol)"
                "nomaxsize, title:^(Wine configuration)$"
              ];
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
              dwindle = {
                smart_resizing = false;
                force_split = 2;
              };
              general = {
                layout = "dwindle";
                border_size = 3;
                gaps_in = 3;
                gaps_out = 6;
                hover_icon_on_border = false;
                resize_on_border = true;
                "col.active_border" = "0xFF" + config.colours.base16.B4;
                "col.inactive_border" = "0xFF" + config.colours.base16.A1;
              };
              input = {
                accel_profile = "flat";
                follow_mouse = 2;
                sensitivity = "-0.1";
              };
              misc = {
                animate_manual_resizes = true;
                animate_mouse_windowdragging = false;
                disable_hyprland_logo = true;
                disable_splash_rendering = true;
                force_default_wallpaper = false;
                vfr = true;
                vrr = 2;
              };
              bind = let
                inherit (pkgs) grimblast grim slurp;
              in [
                "${mod}, RETURN, exec, alacritty"
                "${mod}, TAB, exec, tofi-drun --drun-launch=true"
                "${mod}, BACKSPACE, exec, ${getExe grimblast} --notify --freeze copy area"
                "${mod}:SHIFT, BACKSPACE, exec, ${getExe grimblast} --notify --freeze save area ~/pictures/screenshots/$(date +'%s.png')"
                ''${mod}, P, exec, ${getExe grim} -g "$(${getExe slurp})" -t ppm - | satty --filename - --copy-command wl-copy''
                ''${mod}:SHIFT, P, exec, ${getExe grim} -g "$(${getExe slurp})" -t ppm - | satty --filename - --output-filename ~/pictures/screenshots/satty-$(date '+%H:%M:%S').png''
                "${mod}, L, exec, hyprlock"
                "${mod}, Q, killactive"
                "${mod}, F, fullscreen"
                "${mod}, SPACE, togglefloating"
                "${mod}:SHIFT, M, exit"
                "${mod}, left, movefocus, l"
                "${mod}, right, movefocus, r"
                "${mod}, up, movefocus, u"
                "${mod}, down, movefocus, d"
                "${mod}:SHIFT, left, movewindow, l"
                "${mod}:SHIFT, right, movewindow, r"
                "${mod}:SHIFT, up, movewindow, u"
                "${mod}:SHIFT, down, movewindow, d"
              ];
              bindm = [
                "${mod}, mouse:272, movewindow"
                "${mod}, mouse:273, resizewindow"
              ];
              monitor = [
                "${m1}, 1920x1080@165, 0x0, 1"
                "${m2}, 1920x1080@75, 1920x0, 1"
              ];
              workspace = [
                "1, monitor:${m1}, default:true"
                "5, monitor:${m2}, default:true"
              ];
            };
            extraConfig = let
              inherit (lib) concatMapStringsSep range;
              inherit (builtins) toString;
            in ''
              ${concatMapStringsSep "\n" (n: "workspace=${n}, monitor:${m1}") (map toString (range 1 4))}
              ${concatMapStringsSep "\n" (n: "workspace=${n}, monitor:${m2}") (map toString (range 5 8))}
              ${concatMapStringsSep "\n" (n: "bind=SUPER,${n},workspace,${n}") (map toString (range 1 8))}
              ${concatMapStringsSep "\n" (n: "bind=SUPER:SHIFT,${n},movetoworkspacesilent,${n}") (map toString (range 1 8))}
            '';
          };
        };
        services.greetd = {
          enable = true;
          settings.default_session = {
            command = "${getExe pkgs.greetd.tuigreet} --asterisks -r Hyprland";
            user = "greeter";
          };
        };
      })
      (mkIf paper {
        assertions = assertHm "hyprpaper";
        home-manager.users.pagu = {
          services.hyprpaper = {
            enable = true;
            settings = let
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
      })
      (mkIf idle {
        assertions = assertHm "hypridle";
        home-manager.users.pagu = {
          services.hypridle = {
            enable = true;
            settings = {
              general = {
                lock_cmd = "hyprlock";
                before_sleep_cmd = "hyprlock";
              };
              listener = [
                {
                  timeout = 300;
                  on-timeout = "hyprlock";
                }
              ];
            };
          };
        };
      })
      (mkIf lock {
        assertions = assertHm "hyprlock";
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
                monitor = "${m1}";
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
      })
    ];
}
