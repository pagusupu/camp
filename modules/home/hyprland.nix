{
  config,
  lib,
  pkgs,
  ...
}: {
  options.cute.home.hyprland = lib.mkEnableOption "";
  config = let
    bg = images/blue.jpg;
    m1 = "DP-3";
    m2 = "HDMI-A-1";
    mod = "SUPER";
  in
    lib.mkIf config.cute.home.hyprland {
      home-manager.users.pagu = {
        wayland.windowManager.hyprland = {
          enable = true;
          settings = {
            exec-once = [
              "rwpspread -b swaybg -i ${bg}"
              "waybar"
              "hypridle"
              "hyprlock"
              "steam -silent -console"
            ];
            windowrulev2 = [
              "float, class:(localsend_app)"
              "float, class:(com.saivert.pwvucontrol)"
            ];
            input = {
              follow_mouse = 2;
              accel_profile = "flat";
              sensitivity = "-0.1";
            };
            general = {
              gaps_in = 3;
              gaps_out = 6;
              border_size = 3;
              no_cursor_warps = true;
              resize_on_border = true;
              hover_icon_on_border = false;
              layout = "dwindle";
            };
            dwindle = {
              smart_resizing = false;
              force_split = 2;
            };
            decoration = {
              blur.enabled = false;
              rounding = 6;
            };
            animations = {
              enabled = true;
              first_launch_animation = false;
              animation = [
                "windows, 1, 2, default"
                "border, 1, 2, default"
                "fade, 1, 2, default"
                "workspaces, 1, 1, default, slidevert"
              ];
            };
            misc = {
              vfr = true;
              disable_hyprland_logo = true;
              disable_splash_rendering = true;
              animate_manual_resizes = true;
              animate_mouse_windowdragging = true;
              force_default_wallpaper = false;
            };
            bind = [
              "${mod}, RETURN, exec, alacritty"
              "${mod}, TAB, exec, pidof wofi || wofi --show drun -l 0"
              "${mod}, BACKSPACE, exec, grimblast --notify --freeze copy area"
              "${mod}:SHIFT, BACKSPACE, exec, grimblast --notify --freeze save area ~/pictures/screenshots/$(date +'%s.png')"
              "${mod}, L, exec, hyprlock"
              "${mod}, Q, killactive"
              "${mod}, F, fullscreen"
              "${mod}, SPACE, togglefloating"
              "${mod}, P, pin"
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
          extraConfig = ''
            ${lib.concatMapStringsSep "\n" (n: "workspace=${n}, monitor:${m1}") ["1" "2" "3" "4"]}
            ${lib.concatMapStringsSep "\n" (n: "workspace=${n}, monitor:${m2}") ["5" "6" "7" "8"]}
            ${lib.concatMapStringsSep "\n" (n: "bind=SUPER,${n},workspace,${n}") ["1" "2" "3" "4" "5" "6" "7" "8"]}
            ${lib.concatMapStringsSep "\n" (n: "bind=SUPER:SHIFT,${n},movetoworkspacesilent,${n}") ["1" "2" "3" "4" "5" "6" "7" "8"]}
          '';
        };
        home = {
          packages = with pkgs; [
            imv
            grimblast
            hypridle
            hyprlock
            rwpspread
            swaybg
            wl-clipboard
          ];
          file = {
            "hypridle" = {
              target = ".config/hypr/hypridle.conf";
              text = ''
                general {
                  lock_cmd = pidof hyprlock || hyprlock
                }
                listener {
                  timeout = 300
                  on-timeout = loginctl lock-session
                }
              '';
            };
            "hyprlock" = {
              target = ".config/hypr/hyprlock.conf";
              text = with config.scheme; ''
                general {
                  hide_cursor = true
                  disable_loading_bar = true
                }
                background {
                  monitor =
                  path = screenshot
                  blur_size = 10
                  blur_passes = 4
                }
                input-field {
                  monitor = ${m1}
                  size = 200, 50
                  position = 0, -20
                  halign = center
                  valign = center
                  fade_on_empty = false
                  outline_thickness = 2
                  outer_color = 0xFF${base0D}
                  inner_color = 0xFF${base00}
                  font_color = 0xFF${base05}
                  check_color = 0xFF${base0B}
                  fail_color = 0xFF${base08}
                  capslock_color = 0xFF${base0A}
                  placeholder_text =
                }
              '';
            };
          };
          sessionVariables.NIXOS_OZONE_WL = 1;
        };
      };
      security.pam.services.hyprlock = {};
    };
}
