{
  lib,
  config,
  ...
}: {
  options.cute.programs.bspwm = {
    enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.cute.programs.bspwm.enable {
    xsession.windowManager.bspwm = {
      enable = true;
      startupPrograms = ["discord"];
      monitors = {
        DisplayPort-2 = ["1" "2" "3" "4"];
        HDMI-A-0 = ["5" "6" "7" "8"];
      };
      settings = {
        window_gap = 8;
        border_width = 2;
        normal_border_color = "#${config.cute.colours.primary.bg}";
        focused_border_color = "#${config.cute.colours.primary.main}";
        borderless_monocle = true;
        gapless_monocle = true;
        top_padding = 4;
        bottom_padding = 4;
        left_padding = 4;
        right_padding = 4;
      };
      rules = {
	"discord" = {
	  desktop = "^5";
	};
      };
      extraConfig = ''
        pgrep -x sxhkd > /dev/null || sxhkd &
        feh --bg-fill --no-xinerama ~/Nix/things/images/bg.png
      '';
    };
    services = {
      sxhkd = {
        enable = true;
        keybindings = {
          "super + Return" = "alacritty";
          "super + Tab" = "rofi -show drun";

          "super + shift + BackSpace" = "maim -s ~/Pictures/screenshots/$(date +%s).png";
          "super + BackSpace" = "maim -s | xclip -selection clipboard -t image/png";
          "super + shift + {m,r}" = "bspc {quit,wm -r}"; # quit/restart bspwm
          "super + r" = "pkill -USR1 -x sxhkd"; # reload sxhkd
          "super + {_,shift +}q" = "bspc node -{c,k}"; # close & kill
          "super + @space" = "bspc query --nodes -n focused.tiled && state=floating || state=tiled; \ bspc node --state \~$state"; # toggle floating
          "super + f" = "bspc node --state \~fullscreen"; # toggle fullscreen
          "super + {_,shift +}{Left, Down, Up, Right}" = "bspc node -{f,s} {west,south,north,east}"; #move node focus or position
          "super + {_,shift +}{1-8}" = "bspc {desktop -f,node -d} '^{1-8}'"; # focus or move to workspace
        };
      };
      picom = {
        enable = true;
        backend = "glx";
        fade = true;
	fadeDelta = 1;
        vSync = false;
      };
    };
  };
}
