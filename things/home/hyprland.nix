{
  lib,
  config,
  mcolours,
  ...
}: {
  imports = [../misc/colours.nix];
  options.local.programs.hyprland = {
    config = lib.mkEnableOption "";
  };
  config = lib.mkIf config.local.programs.hyprland.config {
    home.file.".config/hypr/hyprland.conf".text = let
      d1 = "DP-3";
      d2 = "HDMI-A-1";
      b1 = "~/.config/bg/bg1.png";
      b2 = "~/.config/bg/bg2.png";
    in ''
          exec-once=swaybg -o ${d1} -m fill -i ${b1} -o ${d2} -m fill -i ${b2}
          exec-once=waybar
          exec-once=webcord
          windowrule=move ${d2},title:^(webcord)(.*)$
          monitor=${d1},1920x1080@165,1920x0,1
          monitor=${d2},1920x1080@75,0x0,1
          workspace=1, monitor:${d1}, default:true
          workspace=5, monitor:${d2}, default:true
          ${lib.concatMapStringsSep "\n" (n: "workspace=${n}, monitor:${d1}") ["1" "2" "3" "4"]}
          ${lib.concatMapStringsSep "\n" (n: "workspace=${n}, monitor:${d2}") ["5" "6" "7" "8"]}
          ${lib.concatMapStringsSep "\n" (n: "bind=SUPER,${n},workspace,${n}") ["1" "2" "3" "4" "5" "6" "7" "8"]}
          ${lib.concatMapStringsSep "\n" (n: "bind=SUPER:SHIFT,${n},movetoworkspacesilent,${n}") ["1" "2" "3" "4" "5" "6" "7" "8"]}
          input {
            follow_mouse=2
            accel_profile=flat
      sensitivity=-0.1
          }
          general {
            gaps_in=5
            gaps_out=10
            border_size=2
            col.active_border=${"0xFF" + mcolours.primary.main}
            col.inactive_border=${"0xFF" + mcolours.primary.bg}
            no_cursor_warps=true
            resize_on_border=true
            hover_icon_on_border=false
          }
          decoration {
            rounding=5
            multisample_edges=true
            drop_shadow=false
          }
          animations {
            enabled=1
            animation=windows,1,2,default
            animation=border,1,2,default
            animation=fade,1,2,default
            animation=workspaces,1,1,default,slidevert
          }
          misc {
            vrr=1
            vfr=true
            disable_hyprland_logo=true
            disable_splash_rendering=true
            disable_autoreload=false
            animate_manual_resizes=true
            animate_mouse_windowdragging=true
          }
          bind=SUPER,RETURN,exec,alacritty
          bind=SUPER,BACKSPACE,exec,grim -g "$(slurp -d)" - | wl-copy -t image/png
          bind=SUPER:SHIFT,BACKSPACE,exec,grim -g "$(slurp -d)" "$HOME/Pictures/screenshots/$('%H.%M.%S').png"
          bind=SUPER,L,exec,swaylock
          bind=SUPER,TAB,exec,tofi-drun --drun-launch true --terminal alacritty
          bind=SUPER:SHIFT,TAB,exec,~/Nix/things/scripts/powermenu.sh
          bindm=SUPER,mouse:272,movewindow
          bindm=SUPER,mouse:273,resizewindow
          bind=SUPER,Q,killactive,
          bind=SUPER,M,exit,
          bind=SUPER,SPACE,togglefloating,
          bind=SUPER,F,fullscreen,
          bind=SUPER,P,pin,
          bind=SUPER,left,movefocus,l
          bind=SUPER,right,movefocus,r
          bind=SUPER,up,movefocus,u
          bind=SUPER,down,movefocus,d
    '';
  };
}
