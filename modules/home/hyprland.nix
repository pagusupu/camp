{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  options.cute.home.hyprland = lib.mkEnableOption "";
  config = let
    m1 = "DP-3";
    m2 = "HDMI-A-1";
    mod = "SUPER";
  in
    lib.mkIf config.cute.home.hyprland {
      home-manager.users.pagu = {
        wayland.windowManager.hyprland = {
          enable = true;
          package = inputs.hyprland.packages.${pkgs.system}.hyprland;
          settings = {
            exec-once = [
              "hypridle"
              "rwpspread -b swaybg -i ${config.cute.images.bg}"
              "steam -silent -console"
              "${pkgs.localsend}/bin/localsend_app"
              "element-desktop"
              "vesktop"
            ];
            windowrulev2 = [
              "float, class:(thunar)"
              "float, class:(localsend_app)"
              "float, class:(com.saivert.pwvucontrol)"
              "workspace 6, class:(Element)"
              "workspace 5, class:(.sublime-music-wrapped)"
              "workspace 5, class:(vesktop)"
            ];
            input = {
              follow_mouse = 2;
              accel_profile = "flat";
              sensitivity = "-0.1";
            };
            general = {
              gaps_in = 3;
              gaps_out = 6;
              border_size = 2;
              no_cursor_warps = true;
              resize_on_border = true;
              hover_icon_on_border = false;
              "col.active_border" = "0xFF" + config.cute.colours.iris;
              "col.inactive_border" = "0xFF" + config.cute.colours.base;
              layout = "dwindle";
            };
            dwindle = {
              smart_resizing = false;
              force_split = 2;
            };
            decoration = {
              drop_shadow = false;
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
          file = {
            "hyprlock" = {
              source = ./hypr/hyprlock.conf;
              target = ".config/hypr/hyprlock.conf";
            };
            "hypridle" = {
              source = ./hypr/hypridle.conf;
              target = ".config/hypr/hypridle.conf";
            };
          };
          packages = with pkgs; [
            brightnessctl
            imv
            grimblast
            hypridle
            hyprlock
            hyprpaper
            rwpspread
            swaybg
            wl-clipboard
          ];
          sessionVariables = {NIXOS_OZONE_WL = 1;};
        };
      };
      programs.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.system}.hyprland;
      };
      nix.settings = {
        substituters = ["https://hyprland.cachix.org"];
        trusted-public-keys = ["hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="];
      };
    };
}
