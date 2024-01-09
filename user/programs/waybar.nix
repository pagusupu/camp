{
  lib,
  config,
  ...
}: {
  options.hm.programs.waybar.enable = lib.mkEnableOption "";
  config = lib.mkIf config.hm.programs.waybar.enable {
    programs.waybar = {
      enable = true;
      settings = {
        "bar1" = {
          layer = "top";
          position = "left";
          output = ["DP-3"];
          width = 40;
          margin-top = 10;
          margin-bottom = 10;
          margin-left = 10;
	  modules-left = ["hyprland/workspaces"];
	  modules-right = ["clock"];
	  "hyprland/workspaces" = {
	    format = "{icon}";
	    format-icons = {
	      "1" = "1";
	      "2" = "2";
	      "3" = "3";
	      "4" = "4";
	      "5" = "5";
	      "6" = "6";
	      "7" = "7";
	      "8" = "8";
	    };
	    persistent-workspaces = {
	      "1" = ["DP-3"];
	      "2" = ["DP-3"];
	      "3" = ["DP-3"];
	      "4" = ["DP-3"];
	      "5" = ["HDMI-A-1"];
	      "6" = ["HDMI-A-1"];
	      "7" = ["HDMI-A-1"];
	      "8" = ["HDMI-A-1"];
	    };
	  };
	  "clock" = {
	    format = "{: %I \n %M \n %p}";
	  };
        };
      };
      style = ''
        * {
          all: unset;
	  font-family: "MonaspiceNe Nerd Font";
	  font-size: 15px;
        }
        window#waybar {
          background: #${config.cute.colours.primary.bg};
        }
        #workspaces button.active {
	  color: #${config.cute.colours.primary.main};
	}
      '';
    };
  };
}
