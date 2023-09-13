{
  pkgs,
  config,
  lib,
  mcolours,
  ...
}: {
  imports = [../misc/colours.nix];
  options.local.programs.waybar = {
    enable = lib.mkEnableOption "";
  };
  config =
    lib.mkIf config.local.programs.waybar.enable {
      programs.waybar = {
        enable = true;
        package = pkgs.waybar.overrideAttrs (oldAttrs: {
          mesonFlags = oldAttrs.mesonFlags ++ ["-Dexperimental=true"];
        });
        settings = {
          mainbar = {
            layer = "top";
            position = "top";
            output = ["DP-3" "HDMI-A-1"];
            modules-left = ["custom/icon" "clock"];
            modules-center = ["sway/workspaces"];
            modules-right = ["wireplumber" "bluetooth" "network" "custom/powermenu"];
            "sway/workspaces" = {
              format = "{icon}";
              format-icons = {
                "1" = "一";
                "2" = "二";
                "3" = "三";
                "4" = "四";
                "5" = "五";
                "6" = "六";
                "7" = "七";
                "8" = "八";
              };
              persistent_workspaces = {
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
              on-click = "sleep 0.1 && ~/Nix/things/scripts/powermenu.sh";
              tooltip = false;
            };
            "bluetooth" = {
              format = "<span font_size='16pt'></span>";
              tooltip-format-connected = "{device_enumerate}";
              tooltip-format-enumerate-connected = "{device_alias}: {device_address}";
              tooltip-format-enumerated-connected-battery = "{device_alias} - {device_battery_percentage}%: {device_address}";
              tooltip-format = "{controller_alias}: {status}";
            };
            "custom/icon" = {
              format = "<span font_size='16pt'></span>";
            };
            height = 35;
            spacing = 0;
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
            font-family: "Nunito", "Line Awesome Free", "Kosugi Maru";
            font-size: 16px;
          }
          window#waybar {
            background: #${mcolours.primary.bg};
            border-radius: 10px;
          }
          #workspaces {
            margin: 4px;
          }
          #workspaces button {
            padding-top: 0px;
            padding-bottom: 0px;
            padding-left: 2px;
            padding-right: 2px;
            color: #${mcolours.primary.fg};
            background-color: #${mcolours.bright.black};
            border-radius: 6px;
            margin: 2px;
          }
          #workspaces button.focused {
            background-color: #${mcolours.primary.main};
            color: #${mcolours.primary.bg};
            border-radius: 6px;
          }
          #workspaces button:hover {
            background-color: #${mcolours.primary.main};
            color: #${mcolours.primary.bg};
            box-shadow: inherit;
            text-shadow: inherit;
            border-radius: 6px;
          }
          #clock {
            color: #${mcolours.primary.fg};
            padding-top: 0px;
            padding-bottom: 0px;
            padding-right: 0px;
            padding-left: 0px;
          }
          .modules-right {
            color: #${mcolours.primary.fg};
            padding-left: 0px;
            padding-right: 2px;
            padding-top: 0px;
            padding-bottom: 0px;
          }
          #custom-powermenu {
            padding-right: 4px;
          }
          #network {
            padding-right: 2px;
          }
          #custom-icon {
            padding-left: 4px;
            color: #${mcolours.primary.fg};
          }
          tooltip {
            background: #${mcolours.primary.bg};
            color: #${mcolours.primary.fg};
            border: 1px solid #${mcolours.primary.fg};
            border-radius: 6px;
          }
          tooltip label {
            color: #${mcolours.primary.fg};
          }
        '';
      };
    };
}
