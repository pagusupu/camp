{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}:
lib.mkIf (config.cute.desktop.de == "hyprland") {
  assertions = cutelib.assertHm "hyprland";
  programs.hyprland.enable = true;
  home-manager.users.pagu = {
    wayland.windowManager.hyprland = let
      inherit (config.cute.desktop) theme wallpaper-colour;
      wallpaper = ''swaybg -o ${m1} -i ~/pictures/active/${theme}.png -m fill -o ${m2} -c ${wallpaper-colour}'';
      m1 = "DP-3";
      m2 = "HDMI-A-1";
      m = "SUPER";
    in {
      enable = true;
      plugins = with pkgs.hyprlandPlugins; [
        hypr-dynamic-cursors
        hyprspace
      ];
      settings = {
        exec-once = [
          "gtklock -d"
          "${wallpaper}"
          "waybar"
          "mako"
        ];
        exec = lib.mkMerge [
          ["kill $(pidof swaybg)" "${wallpaper}"]
          (let
            inherit (config.home-manager.users.pagu.home.pointerCursor) name size;
          in ["hyprctl setcursor ${name} ${builtins.toString size}"])
        ];
        env = [
          "_JAVA_AWT_WM_NONREPARENTING,1"
          "NIXOS_OZONE_WL,1"
        ];
        windowrulev2 = [
          "workspace 5, class:^(feishin)$"
          "workspace 5, class:^(discord)$"
          "float, class:^(localsend)$"
          "float, title:^(Steam - News)$"
          "float, class:^(steam)$,title:^(Special Offers)$"
          "float, title:^(Open Files)$"
          "float, class:^(thunar)$"
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
        cursor = {
          default_monitor = m1;
          no_hardware_cursors = true;
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
          "col.active_border" = "0xFF" + config.colours.iris;
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
        plugin = {
          dynamic-cursors = {
            stretch = {
              limit = 6000;
              function = "linear";
            };
            mode = "stretch";
            shake.enabled = false;
          };
          overview = with config.colours; {
            panelColor = "rgb(${overlay})";
            panelBorderColor = "rgb(${iris})";
            workspaceActiveBorder = "rgb(${iris})";
            workspaceInactiveBorder = "rgb(${subtle})";
          };
        };
        bind = [
          "${m}, RETURN, exec, alacritty"
          "${m}, TAB, exec, wofi"
          "${m}:SHIFT, TAB, overview:toggle"
          "${m}, L, exec, gtklock"

          "${m}, BACKSPACE, exec, grimblast --notify --freeze copy area"
          "${m}:SHIFT, BACKSPACE, exec, grimblast --notify --freeze save area ~/pictures/screenshots/$(date +'%s.png')"
          ''${m}, P, exec, grim -g "$(slurp)" -t ppm - | satty --filename - --copy-command wl-copy''
          ''${m}:SHIFT, P, exec, grim -g "$(slurp)" -t ppm - | satty --filename - --output-filename ~/pictures/screenshots/satty-$(date '+%H:%M:%S').png''

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
      grim
      grimblast
      rwpspread
      satty
      slurp
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
  cute.desktop.programs = let
    inherit (lib) mkDefault;
  in {
    idle = mkDefault true;
    mako = mkDefault true;
    waybar = mkDefault true;
    wlogout = mkDefault true;
    wofi = mkDefault true;
  };
}
