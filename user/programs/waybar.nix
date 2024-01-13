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
	  #spacing = 6;
          margin-top = 10;
          margin-bottom = 10;
          margin-left = 10;
          modules-left = ["hyprland/workspaces"];
          modules-right = ["pulseaudio/slider" "pulseaudio" "clock"];
	  "clock" = {
            format = "{: %I \n %M \n %p}";
          };
	  "pulseaudio/slider" = {
	    min = 0;
	    max = 99;
	    orientation = "vertical";
	  };
	  "pulseaudio" = {
	    format = "{volume}";
	    format-muted = "--";
	    on-click-right = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
	    scroll-step = 0;
	    tooltip = false;
	  };
	  "hyprland/workspaces" = {
            format = "{icon}";
            format-icons = {
              "1" = "1";
              "2" = "2";
              "3" = "3";
              "4" = "4";
            };
            persistent-workspaces = {
              "1" = ["DP-3"];
              "2" = ["DP-3"];
              "3" = ["DP-3"];
              "4" = ["DP-3"];
            };
          }; 
        };
      };
      style = ''
        * {
          all: unset;
          font-family: "MonaspiceNe Nerd Font";
          font-size: 15px;
        }
	.modules-right {
	  padding-bottom: 6px;
	}
	.modules-left {
	  padding-top: 6px;
	}
        window#waybar {
          background: #${config.cute.colours.base};
	}
	#workspaces button.active {
          color: #${config.cute.colours.iris};
        }
	#pulseaudio,
        #pulseaudio-slider {
	  background-color: #${config.cute.colours.overlay};
	  padding-top: 10px;
	  padding-bottom: 10px;
	}
        #pulseaudio-slider slider {
	  min-height: 0px;
	  min-width: 0px;
	  opacity: 0;
	  background-image: none;
	  border: none;
	  box-shadow: none;
	}
	#pulseaudio-slider trough {
	  min-height: 100px;
	  min-width: 20px;
	  background-color: #${config.cute.colours.surface};
	}
	#pulseaudio-slider highlight {
	  min-width: 20px;
	  background-color: #${config.cute.colours.iris};
	}
      '';
    };
  };
}
