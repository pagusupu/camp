{config, ...}: {
  services.polybar = {
    enable = true;
    script = '' 
    '';
    settings = {
      "bar/clock" = {
	monitor = "DisplayPort-2";
	width = "6.5%";
	height = "3%";
	offset-x = "2.6%";
	offset-y = "0.89%";
	font-0 = "firacode nerd font:size=12;2";
	font-1 = "symbols nerd font:style=regular:size=14;2";
	background = "#${config.cute.colours.primary.bg}";
	foreground = "#${config.cute.colours.primary.fg}";
	module-margin = "4px";
	modules-center = "clock";
      };
      "module/clock" = {
	type = "internal/date";
	internal = "1";
	time = "%I:%M %p";
	time-alt = "%d %a %b";
	label = "%{T2 F#${config.cute.colours.primary.main}}%{F- T-} %time%";
      };
      "bar/logo" = {
	monitor = "DisplayPort-2";
	width = "1.7%";
	height = "3%";
	offset-x = "0.5%";
	offset-y = "0.89%";
	font-0 = "symbols nerd font:style=regular:size=18;3";
	background = "#${config.cute.colours.primary.bg}";
	foreground = "#${config.cute.colours.primary.fg}";
	modules-center = "logo";
      };
      "module/logo" = {
	type = "custom/text";
	content = "%{T1 F#${config.cute.colours.normal.blue}}%{F- T-}";
      };
      "bar/workspaces" = {
	monitor = "DisplayPort-2";
	width = "5%";
	height = "3%";
	offset-x = "47.5%";
	offset-y = "0.89%";
	font-0 =  "firacode nerd font:style=regular:size=14;2"; 
        background = "#${config.cute.colours.primary.bg}";
	foreground = "#${config.cute.colours.primary.fg}";
	modules-center = "workspaces";
      };
      "module/workspaces" = {
	type = "internal/bspwm";
	enable-scroll = "false";
	label-focused-foreground = "#${config.cute.colours.primary.main}";
      };
      "bar/powermenu" = {
	monitor = "HDMI-A-0";
	width = "1.7%";
	height = "3%";
	offset-x = "97.9%";
	offset-y = "0.89%";
        font-0 = "symbols nerd font:style=regular:size=18;3";
        background = "#${config.cute.colours.primary.bg}";
	foreground = "#${config.cute.colours.primary.fg}";
	modules-center = "powermenu";
      };
      "module/powermenu" = {
	type = "custom/text";
        content = "%{T1 F#${config.cute.colours.normal.red}}%{F- T-}";
	click-left = "~/Nix/user/scripts/powermenu.sh";
      }; 
    };
  };
}
