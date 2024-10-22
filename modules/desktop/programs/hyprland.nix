{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}: {
  options.cute.desktop.programs.hyprland = cutelib.mkEnable;
  config = lib.mkIf config.cute.desktop.programs.hyprland {
    assertions = cutelib.assertHm "hyprland";
    programs.hyprland.enable = true;
    home-manager.users.pagu = {
      wayland.windowManager.hyprland = let
        inherit (config.cute.desktop.misc) theme wallpaper-colour;
        wallpaper = ''swaybg -o ${m1} -i ~/pictures/active/${theme}.png -m fill -o ${m2} -c ${wallpaper-colour}'';
        m1 = "DP-3";
        m2 = "HDMI-A-1";
        m = "SUPER";
      in {
        enable = true;
        settings = {
          exec-once = [
            "gtklock -d"
            "${wallpaper}"
            "waybar"
            "mako"
            "sublime-music"
            "discord"
          ];
          exec = let
            inherit (config.home-manager.users.pagu.home.pointerCursor) name size;
          in [
            "kill $(pidof swaybg)"
            "${wallpaper}"
            "hyprctl setcursor ${name} ${builtins.toString size}"
          ];
          env = [
            "NIXOS_OZONE_WL,1"
            "_JAVA_AWT_WM_NONREPARENTING,1"
          ];
          windowrulev2 = [
            "workspace 5, class:^(.sublime-music-wrapped)$"
            "workspace 5, class:^(discord)$"
            "float, class:^(localsend)$"
            "float, title:^(Steam - News)$"
            "float, class:^(steam)$,title:^(Special Offers)$"
            "float, title:^(Open Files)$"
            "float, class:^(thunar)$"
            "size 1300 800, title:^(Keyguard)$"
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
            "col.active_border" = "0xFF" + config.colours.love;
            "col.inactive_border" = "0xFF" + config.colours.overlay;
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
            "${m}, RETURN, exec, alacritty"
            "${m}, TAB, exec, tofi-drun && rm ~/.cache/tofi-drun"
            "${m}, BACKSPACE, exec, ${getExe grimblast} --notify --freeze copy area"
            "${m}:SHIFT, BACKSPACE, exec, ${getExe grimblast} --notify --freeze save area ~/pictures/screenshots/$(date +'%s.png')"
            ''${m}, P, exec, ${getExe grim} -g "$(${getExe slurp})" -t ppm - | satty --filename - --copy-command wl-copy''
            ''${m}:SHIFT, P, exec, ${getExe grim} -g "$(${getExe slurp})" -t ppm - | satty --filename - --output-filename ~/pictures/screenshots/satty-$(date '+%H:%M:%S').png''
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
        systemd.variables = ["--all"];
      };
      home.packages = with pkgs; [
        rwpspread
        satty
        swaybg
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
  };
}
