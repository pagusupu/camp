{
  config,
  lib,
  pkgs,
  ...
}: {
  options.hm.programs.hyprland.config = lib.mkEnableOption "";
  config = let
    m1 = "DP-3";
    m2 = "HDMI-A-1";
    bg = "/home/pagu/flake/user/images/bg.jpg";
    mod = "SUPER";
  in
    lib.mkIf config.hm.programs.hyprland.config {
      wayland.windowManager.hyprland = {
        enable = true;
        settings = {
          exec-once = [
            "swaylock"
            "swayidle -w before-sleep 'swaylock'"
	    "swaybg -i ${bg} -o ${m1} -m center"
	    "swaybg -i ${bg} -o ${m2} -m center"
	    "waybar"
	   # "vencorddesktop"
          ];
          monitor = [
            "${m1}, 1920x1080@165, 0x0, 1"
            "${m2}, 1920x1080@75, 1920x0, 1"
          ];
          input = {
            follow_mouse = 2;
            accel_profile = "flat";
            sensitivity = "-0.1";
          };
          general = {
            gaps_in = 5;
            gaps_out = 10;
            border_size = 2;
            "col.active_border" = "${"0xFF" + config.cute.colours.iris}";
            "col.inactive_border" = "${"0xFF" + config.cute.colours.base}";
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
            drop_shadow = false;
          };
          animations = {
            enabled = true;
            animation = [
              "windows, 1, 2, default"
              "border, 1, 2, default"
              "fade, 1, 2, default"
              "workspaces, 1, 1, default, slidevert"
            ];
          };
          misc = {
            vrr = 1;
            vfr = true;
            disable_hyprland_logo = true;
            disable_splash_rendering = true;
            animate_manual_resizes = true;
            animate_mouse_windowdragging = true;
          };
          bind = [
            "${mod}, RETURN, exec, alacritty"
            "${mod}, TAB, exec, wofi --show drun"
	    "${mod}, L, exec, swaylock"
	    "${mod}, BACKSPACE, exec, hyprshot -m region --clipboard-only"
	    "${mod}:SHIFT, BACKSPACE, exec, hyprshot -m region -o ~/pictures/screenshots"

            "${mod}, Q, killactive"
            "${mod}, M, exit"
            "${mod}, F, fullscreen"
            "${mod}, SPACE, togglefloating"
            "${mod}, P, pin"

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
      home.packages = with pkgs; [
        swayidle
	swaybg
	wl-clipboard
	imv
      ];
    };
}
