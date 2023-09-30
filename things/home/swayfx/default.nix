{
  pkgs,
  config,
  lib,
  mcolours,
  ...
}: {
  options.cute.programs.swayfx = {
    enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.cute.programs.swayfx.enable {
    home = {
      packages = [pkgs.swayfx];
      file.".config/sway/config".text = ''
        include /home/pagu/Nix/things/home/swayfx/float-compat
        include /home/pagu/Nix/things/home/swayfx/workspace-move
        set $mod Mod4
        set $term alacritty
        set $menu tofi-drun --drun-launch true --terminal alacritty
        set $d1 "DP-3"
        set $d2 "HDMI-A-1"
        exec waybar
        exec bluetoothctl
        exec mako
        exec discord
        output $d1 {
          mode 1920x1080
          pos 1920,0
          adaptive_sync on
        }
        output $d2 {
          mode 1920x1080
          pos 0,0
          adaptive_sync on
        }
        default_border pixel 2
        corner_radius 5
        gaps {
          inner 5
          outer 3
        }
        floating_maximum_size 1600 x 800
        floating_minimum_size 160 x 120
        floating_modifier $mod normal
        mouse_warping none
        input * {
          accel_profile flat
          natural_scroll disable
          pointer_accel -0.1
        }
        bindsym $mod+space layout toggle split
        bindsym $mod+Shift+space floating toggle
        bindsym $mod+f fullscreen
        bindsym $mod+p sticky toggle
        bindsym $mod+Return exec $term
        bindsym $mod+Tab exec $menu
        bindsym $mod+Shift+Tab exec ~/Nix/things/home/waybar/scripts/powermenu.sh
        bindsym $mod+l exec swaylock
        bindsym $mod+n exec ~/Nix/thingshome/waybar/scripts/dnd-toggle.sh
        bindsym $mod+Backspace exec grim -g "$(slurp -d)" - | wl-copy -t image/png
        bindsym $mod+Shift+Backspace exec grim -g "$(slurp -d)" "$HOME/Pictures/screenshots"/"$(date '+%H-%M-%S')".png
        bindsym $mod+r reload
        bindsym $mod+m exec swaymsg exit
        bindsym $mod+q kill
        xwayland force
      '';
    };
  };
}
