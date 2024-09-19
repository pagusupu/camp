{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}: {
  options.cute.desktop.hypr.land = cutelib.mkEnable;
  config = lib.mkIf config.cute.desktop.hypr.land {
    assertions = cutelib.assertHm "hyprland";
    home-manager.users.pagu = {
      wayland.windowManager.hyprland = let
        m1 = "DP-3";
        m2 = "HDMI-A-1";
        m = "SUPER";
      in {
        enable = true;
        settings = {
          exec-once = [
            "gtklock -d"
            "hyprpaper"
            "waybar"
            "mako"
            "wayland-pipewire-idle-inhibit"
            "ianny"
            "steam -console -silent"
          ];
          exec = let
            inherit (config.home-manager.users.pagu.home.pointerCursor) name size;
          in [
            "hyprctl setcursor ${name} ${builtins.toString size}"
            "rm ~/.cache/tofi-drun"
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
            inherit (lib) getExe;
            inherit (pkgs) grimblast grim satty slurp;
          in [
            "${m}, RETURN, exec, alacritty"
            "${m}, TAB, exec, tofi-drun"
            "${m}, BACKSPACE, exec, ${getExe grimblast} --notify --freeze copy area"
            "${m}:SHIFT, BACKSPACE, exec, ${getExe grimblast} --notify --freeze save area ~/pictures/screenshots/$(date +'%s.png')"
            ''${m}, P, exec, ${getExe grim} -g "$(${getExe slurp})" -t ppm - | ${getExe satty} --filename - --copy-command wl-copy''
            ''${m}:SHIFT, P, exec, ${getExe grim} -g "$(${getExe slurp})" -t ppm - | ${getExe satty} --filename - --output-filename ~/pictures/screenshots/satty-$(date '+%H:%M:%S').png''
            "${m}, L, exec, gtklock"
            "${m}, Q, killactive"
            "${m}, F, fullscreen"
            "${m}, SPACE, togglefloating"
            "${m}:SHIFT, M, exit"
            "${m}, left, movefocus, l"
            "${m}, right, movefocus, r"
            "${m}, up, movefocus, u"
            "${m}, down, movefocus, d"
            "${m}:SHIFT, left, movewindow, l"
            "${m}:SHIFT, right, movewindow, r"
            "${m}:SHIFT, up, movewindow, u"
            "${m}:SHIFT, down, movewindow, d"
          ];
          bindm = [
            "${m}, mouse:272, movewindow"
            "${m}, mouse:273, resizewindow"
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
      home.packages = with pkgs; [
        gtklock
        ianny
        satty
        wayland-pipewire-idle-inhibit
        wl-clipboard
      ];
    };
    services.greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "${lib.getExe pkgs.hyprland}";
          user = "pagu";
        };
        default_session = initial_session;
      };
    };
    security.pam.services.gtklock = {};
  };
}