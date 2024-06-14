{
  config,
  lib,
  _lib,
  pkgs,
  ...
}: let
  inherit (lib) getExe;
in {
  options.cute.desktop.wm.hyprland = lib.mkEnableOption "";
  config = lib.mkIf config.cute.desktop.wm.hyprland {
    assertions = _lib.assertHm;
    home-manager.users.pagu = {
      home.packages = builtins.attrValues {
        inherit
          (pkgs)
          rwpspread
          swaybg
          wl-clipboard
          ;
      };
      wayland.windowManager.hyprland = let
        m1 = "DP-3";
        m2 = "HDMI-A-1";
        mod = "SUPER";
      in {
        enable = true;
        settings = {
          exec-once = [
            "rwpspread -b swaybg -i ~/camp/misc/images/bg.jpg"
            "waybar"
            "hyprlock"
            "wayland-pipewire-idle-inhibit"
          ];
          env = [
            "NIXOS_OZONE_WL,1"
            "_JAVA_AWT_WM_NONREPARENTING,1"
          ];
          windowrulev2 = [
            "float, class:(localsend_app)"
            "float, class:(com.saivert.pwvucontrol)"
          ];
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
            "col.active_border" = "0xFF" + config.scheme.base0B;
            "col.inactive_border" = "0xFF" + config.scheme.base00;
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
          bind = [
            "${mod}, RETURN, exec, alacritty"
            "${mod}, TAB, exec, anyrun"
            "${mod}, N, exec, swaync-client -op"
            "${mod}, BACKSPACE, exec, ${getExe pkgs.grimblast} --notify --freeze copy area"
            "${mod}:SHIFT, BACKSPACE, exec, ${getExe pkgs.grimblast} --notify --freeze save area ~/pictures/screenshots/$(date +'%s.png')"
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
    cute.desktop.misc.greetd = {
      enable = true;
      command = "${getExe pkgs.hyprland}";
    };
  };
}
