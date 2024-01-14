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
              "1" = "01";
	      "2" = "02";
	      "3" = "03";
	      "4" = "04";
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
      style = let
        inherit (config.cute) colours;
      in ''
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
          background: #${colours.base};
        }
	#workspaces button:hover {
          background: #${colours.base};
          border: #${colours.base};
          padding: 0 3px;
	  box-shadow: inherit;
          text-shadow: inherit;
        }
        #workspaces button.active {
          color: #${colours.iris};
        }
	#workspaces button.visible {
	  color: #${colours.iris};
	}
	#clock {
	 /* background-color: #${colours.overlay}; */
	  padding-top: 6px;
	}
        #pulseaudio {
          background-color: #${colours.overlay};
	/*  border-bottom: #${colours.iris}; */
          padding-top: 6px;
          padding-bottom: 4px;
	  margin-left: 4px;
	  margin-right: 4px;
	  margin-bottom: 4px;
        }
	#pulseaudio-slider {
	  background-color: #${colours.overlay};
	  padding-top: 6px;
	  margin-top: 4px;
	  margin-left: 4px;
	  margin-right: 4px;
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
          background-color: #${colours.surface};
        }
        #pulseaudio-slider highlight {
          min-width: 20px;
          background-color: #${colours.iris};
        }
      '';
    };
  };
}
