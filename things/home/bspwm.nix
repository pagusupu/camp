{
  lib,
  config,
  pkgs,
  mcolours,
  ...
}: {
  imports = [../misc/home/colours.nix];
  options.cute.programs.bspwm = {
    enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.cute.programs.bspwm.enable {
    xsession.windowManager.bspwm = {
      enable = true;
      package = [pkgs.bspwm];
      startupPrograms = ["sxhkd"];
      monitors = {
        DP-3 = ["1" "2" "3" "4"];
        HDMI-A-1 = ["5" "6" "7" "8"];
      };
      settings = {
        border_width = 2;
        window_gap = 16;
        borderless_monocle = true;
        gapless_monocle = true;
        top_padding = 60;
        bottom_padding = 60;
        left_padding = 60;
        right_padding = 60;
        #pointer_action1 = -g move;
        #pointer_actions2 = resize_side;
        #pointer_action2 = resize_corner;
        focus_follows_pointer = true;
      };
    };
    services.sxhkd = {
      enable = true;
      keybindings = {
        "super + enter" = "alacritty";
        #add other apps
        "super + shift + {m,r}" = "bspc {quit,wm -r}"; # quit/restart bspwm
        "super + r" = "pkill -USR1 -x sxhkd"; # reload sxhkd
        "super + @space" = "bspc query --nodes -n focused.tiled && state=floating || state=tiled; \ bspc node --state \~$state"; # toggle floating
        "super + f" = "bspc node --state \~fullscreen"; # toggle fullscreen
        "super + g" = "bspc node -s biggest.window"; # swap node with biggest window
        "super + {Left,Down,Up,Right}" = "bspc node -{f,s} {west,south,north,east}"; #move node focus
        #add move node position
        "super + {_,shift +}{1-8}" = "bspc {desktop -f,node -d} '^{1-8}'"; # focus or move to workspace
      };
    };
  };
}
