{
  lib,
  config,
  pkgs,
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
          width = 44;
          output = ["DP-3"];
          modules-left = ["custom/nix" "clock"];
          modules-center = ["hyprland/workspaces"];
          modules-right = ["pulseaudio/slider" "pulseaudio" "tray" "custom/dnd" "network" "custom/powermenu"];
          "clock" = {
            format = "{: %I \n %M \n %p}";
          };
          "tray" = {
            icon-size = 20;
            spacing = 4;
            show-passive-items = true;
          };
          "network" = {
            format-wifi = "";
            format-ethernet = "󰈀";
            format = "!";
            tooltip = false;
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
              default = "󰝣";
              active = "󰝤";
            };
            persistent-workspaces = {
              "1" = ["DP-3"];
              "2" = ["DP-3"];
              "3" = ["DP-3"];
              "4" = ["DP-3"];
            };
          };
	  "custom/nix" = {
	    format = "󱄅";
	    tooltip = false;
	  };
          "custom/dnd" = let
            dndclass = pkgs.writeShellScript
              "dnd-class.sh" ''
                if [ "$(makoctl mode)" = "default" ]; then
                    echo '{"class":"disabled"}';
                else
                    echo '{"class":"enabled"}';
                fi 
	      '';
	    dndswap = pkgs.writeShellScript
	      "dnd-swap.sh" ''
	        if [ "$(makoctl mode)" = "default" ]; then
		    exec "$(makoctl mode -s do-not-disturb)";
		else
		    exec "$(makoctl mode -s default)";
		fi
	      '';
          in {
            format = "󰂚";
            return-type = "json";
            exec = "${dndclass}";
	    on-click = "${dndswap}";
	    exec-on-event = true;
	    interval = "once";
	    tooltip = false;
          };
	  "custom/powermenu" = {
	    format = "󰐥";
	    tooltip = false;
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
        #workspaces {
          background: #${colours.overlay};
          border-bottom: 2px solid #${colours.iris};
          margin: 6px;
          padding-top: 6px;
          padding-bottom: 6px;
        }
        #workspaces button:hover {
          background: #${colours.overlay};
          border: #${colours.overlay};
          padding: 0px;
          box-shadow: inherit;
          text-shadow: inherit;
        }
        #workspaces button {
          color: #${colours.iris};
	  font-size: 18px;
        }
        #clock {
          background-color: #${colours.overlay};
          padding-top: 6px;
          padding-bottom: 6px;
          margin-bottom: 6px;
          margin-left: 6px;
          margin-right: 6px;
	  margin-top: 6px;
          border-bottom: 2px solid #${colours.iris};
        }
        #network {
          padding-top: 7px;
          padding-right: 6px;
          padding-bottom: 7px;
          margin: 6px;
          background-color: #${colours.overlay};
          border-bottom: 2px solid #${colours.iris};
        }
	#custom-nix {
	  background-color: #${colours.overlay};
	  border-bottom: 2px solid #${colours.iris};
	  font-size: 24px;
	  margin-left: 6px;
	  margin-right: 6px;
	  margin-bottom: 6px;
	  padding-right: 3px;
	  padding-top: 2px;
	  padding-bottom: 2px;
	}
	#custom-dnd {
	  background-color: #${colours.overlay};
	  border-bottom: 2px solid #${colours.iris};
	  color: #${colours.text};
	  margin: 6px;
	  padding: 6px;
	  font-size: 18px;
	}
	#custom-dnd.enabled {
	  color: #${colours.text};
	}
	#custom-dnd.disabled {
	  color: #${colours.love};
	}
	#custom-powermenu {
	  background-color: #${colours.overlay};
	  border-bottom: 2px solid #${colours.iris};
	  padding-top: 4px;
	  padding-bottom: 4px;
	  margin-top: 6px;
	  margin-left: 6px;
	  margin-right: 6px;
	  font-size: 20px;
	}
        #tray {
          padding-top: 6px;
          padding-bottom: 6px;
          background-color: #${colours.overlay};
          color: #${colours.text};
          margin: 6px;
          border-bottom: 2px solid #${colours.iris};
        }
        #tray menu {
          background: #${colours.surface};
          color: #${colours.text};
          padding: 4px;
          border: 1px solid #${colours.iris};
        }
        #tray > .needs-attention {
          color: #${colours.love};
        }
        #pulseaudio {
          background-color: #${colours.overlay};
          border-bottom: 2px solid #${colours.iris};
          padding-top: 6px;
          padding-bottom: 4px;
          margin-left: 6px;
          margin-right: 6px;
          margin-bottom: 6px;
        }
        #pulseaudio-slider {
          background-color: #${colours.overlay};
          padding-top: 6px;
          margin-top: 6px;
          margin-left: 6px;
          margin-right: 6px;
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
        tooltip {
          background-color: transparent;
        }
        tooltip label {
          color: #${colours.text};
          background-color: #${colours.surface};
      /*  margin-bottom: 30px; */
          margin-left: 34px;
          padding: 6px;
          border: 1px solid #${colours.iris};
        }
      '';
    };
  };
}
