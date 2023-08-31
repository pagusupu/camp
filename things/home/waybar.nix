{
  pkgs,
  mcolours,
  config,
  lib,
  ...
}: {
  options.local.programs.waybar = {
    enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.local.programs.waybar.enable {
    programs.waybar = {
      enable = true;
      package = pkgs.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
        postPatch = ''
          substituteInPlace src/modules/wlr/workspace_manager.cpp --replace "zext_workspace_handle_v1_activate(workspace_handle_);" "const std::string command = \"${pkgs.hyprland}/bin/hyprctl dispatch workspace \" + name_; system(command.c_str());"
        '';
      });
      settings = {
        mainbar = {
          layer = "top";
          position = "top";
          output = ["DP-3" "HDMI-A-1"];
          modules-left = ["clock"];
          modules-center = ["hyprland/workspaces"];
          modules-right = ["wireplumber" "bluetooth" "network" "custom/powermenu"];
          "hyprland/workspaces" = {
            format = "{icon}";
            format-icons = {
              "1" = "<span color='#8A98AC'>壹</span>";
              "2" = "<span color='#8F8AAC'>貳</span>";
              "3" = "<span color='#AC8AAC'>参</span>";
              "4" = "<span color='#AC8A8C'>肆</span>";
              "5" = "<span color='#8A98AC'>伍</span>";
              "6" = "<span color='#8F8AAC'>陸</span>";
              "7" = "<span color='#AC8AAC'>柒</span>";
              "8" = "<span color='#AC8A8C'>捌</span>";
            };
            persistent_workspaces = {
              "*" = 4;
            }; 
          };
          "clock" = {
            format = "{:%I:%M %p}";
            format-alt = "{:%I:%M %p, %A %B %d, %Y}";
          };
          "network" = {
              format = "<span font_size='16pt'></span>";
              format-ethernet = "<span font_size='16pt'></span>";
              format-wifi = "<span font_size='16pt'></span>";
              interval = 1;
              tooltip-format = "Connected, No Internet";
              tooltip-format-disconnected = "No Connection";
              tooltip-format-ethernet = "{ifname}
{bandwidthUpBits}
{bandwidthDownBits}";
              tooltip-format-wifi = "{essid}
{signalStrength}
{bandwidthUpBits}
{bandwidthDownBits}";
          };
          "wireplumber" = {
            format = "<span font_size='16pt'></span>";
	    format-muted = "<span font_size='16pt'></span>";
            tooltip-format = "{node_name} {volume}%";
            on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
            on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
            on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
          };
          "custom/powermenu" = {
            format = "<span font_size='16pt'></span>";
            on-click = "sleep 0.1 && /etc/nixos/things/scripts/powermenu.sh";
            tooltip = false;
          };
          "bluetooth" = {
             format = "<span font_size='16pt'></span>";
             tooltip-format-connected = "{device_enumerate}";
             tooltip-format-enumerate-connected = "{device_alias}: {device_address}";
             tooltip-format-enumerated-connected-battery = "{device_alias} - {device_battery_percentage}%: {device_address}";
             tooltip-format = "{controller_alias}: {status}";
          };
          height = 30;
          spacing = 4;
          margin-top = 10;
          margin-bottom = 0;
          margin-left = 10;
          margin-right = 10;
        };
      };
      style = ''
        * {
          border: none;
          min-height: 0;
          margin: 0;
          padding: 0;
          font-family: "Nunito", "la-regular-lg", "Kosugi Maru";
          font-size: 16px;
        }
        window#waybar {
          background: #191919;
          border-radius: 5px;
        }
        #workspaces button {
          padding-top: 2px;
          padding-bottom: 2px;
          padding-left: 2px;
          padding-right: 2px;
        }
        #workspaces button.active {
          background: transparent;
          border-bottom: 2px solid #bfbfbf;
          border-radius: 0px;
        }
        #workspaces button:hover {
          background: transparent;
          box-shadow: inherit;
          text-shadow: inherit;
          border-bottom: 2px solid #a0a0a0;
          border-radius: 0px;
        }
        #clock {
          color: #a0a0a0;
          padding-top: 2px;
          padding-bottom: 2px;
          padding-right: 3px;
          padding-left: 6px;
        }
	#custom-icon {
	  color: #a0a0a0;
	  padding-left: 2px;
	}
        .modules-right {
          color: #a0a0a0;
          padding-left: 0px;
          padding-right: 0px;
          padding-top: 2px;
          padding-bottom: 2px;
        }
        #custom-powermenu {
	  padding-right: 4px;
	}
	#network {
          padding-right: 2px;
        }
        tooltip {
          background: #191919;
          color: #a0a0a0;
          border: 1px solid #a0a0a0;
          border-radius: 7px;
        }
        tooltip label {
          color: #a0a0a0;
        }
      '';
    };
  };
}
