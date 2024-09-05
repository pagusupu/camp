{
  config,
  lib,
  _lib,
  pkgs,
  ...
}: {
  options.cute.desktop.hypr.land = _lib.mkEnable;
  config = lib.mkIf config.cute.desktop.hypr.land {
    assertions = _lib.assertHm "hyprland";
    home-manager.users.pagu = {
      home.packages = with pkgs; [
        rwpspread
        satty
        swaybg
        wayland-pipewire-idle-inhibit
        wl-clipboard
      ];
      wayland.windowManager.hyprland = let
        m1 = "DP-3";
        m2 = "HDMI-A-1";
        mod = "SUPER";
      in {
        enable = true;
        settings = {
          exec-once = [
            "rwpspread -b swaybg -i ~/pictures/wallpapers/blueflip.jpg"
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
            inherit (lib) getExe;
            inherit (pkgs) grimblast grim slurp;
          in [
            "${mod}, RETURN, exec, alacritty"
            "${mod}, TAB, exec, tofi-drun"
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
        command = "${lib.getExe pkgs.greetd.tuigreet} --asterisks -r --cmd ${lib.getExe pkgs.hyprland}";
        user = "greeter";
      };
    };
  };
}
