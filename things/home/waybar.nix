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
            modules-left = ["image#nix" "custom/version" "custom/user"];
            modules-center = ["sway/workspaces"];
            modules-right = ["wireplumber" "bluetooth" "network" "clock" "custom/dnd" "custom/powermenu"];
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
              format = "{:%I:%M %p} ";
              tooltip-format = "{:%A %B %d, %Y}";
            };
            "network" = {
              format = "";
              format-ethernet = "{ifname} ";
              format-wifi = "{essid} ";
              format-disconnected = "No Connection";
              tooltip-format-ethernet = "{bandwidthUpBits}
{bandwidthDownBits}";
              tooltip-format-wifi = "{signalStrength}
{bandwidthUpBits}
{bandwidthDownBits}";
              interval = 1;
            };
            "wireplumber" = {
              format = "{volume}% {icon}";
              format-icons = ["" "" ""];
              format-muted = "muted ";
              tooltip-format = "{node_name}";
              on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
              on-scroll-up = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+";
              on-scroll-down = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
            };
            "custom/powermenu" = {
              format = "";
              on-click = "sleep 0.1 && ~/Nix/things/scripts/powermenu.sh";
              tooltip = false;
            };
            "bluetooth" = {
              format = "{status} ";
              tooltip-format-connected = "{device_enumerate}";
              tooltip-format-enumerate-connected = "{device_alias}: {device_address}";
              tooltip-format = "Searching...";
            };
            "image#nix" = {
              path = "/home/pagu/Nix/things/images/nixos-logo-alt.png";
              size = 20;
              interval = 30;
            };
            "custom/version" = {
              format = "23.11 (unstable)";
              tooltip = false;
            };
            "custom/user" = {
              format = " pagu";
              tooltip = false;
            };
            "custom/dnd" = {
              format = "{}";
              exec = "~/Nix/things/scripts/dnd-status.sh";
              on-click = "~/Nix/things/scripts/dnd-toggle.sh";
              return-type = "json";
              signal = 11;
              interval = 1;
            };
            height = 32;
            spacing = 4;
          };
        };
        style = ''
          * {
            border: none;
            min-height: 0;
            margin: 0;
            padding: 0;
            font-family: "Nunito", "Font Awesome 6 Free", "Kosugi Maru";
            font-size: 15px;
          }
          window#waybar {
            background: #${mcolours.primary.bg};
            border-radius: 0px;
          }
          #workspaces {
            margin: 2px;
          }
          #workspaces button {
            padding-left: 2px;
            padding-right: 2px;
            color: #${mcolours.primary.main};
            background-color: #${mcolours.bright.black};
            border-radius: 6px;
            margin: 2px;
          }
          #workspaces button.current_output {
            background-color: #${mcolours.primary.main};
            color: #${mcolours.primary.bg};
            border-radius: 6px;
          }
          #workspaces button.focused {
            background-color: #${mcolours.bright.red};
            color: #${mcolours.primary.bg};
            border-radius: 6px;
          }
          #workspaces button:hover {
            background-color: #${mcolours.bright.red};
            color: #${mcolours.primary.bg};
            box-shadow: inherit;
            text-shadow: inherit;
            border-radius: 6px;
          }
          .modules-left {
            margin: 4px;
            padding-right: 2px;
          }
          #custom-version,
          #custom-user {
            padding-right: 4px;
            padding-left: 4px;
            color: #${mcolours.primary.main};
            background-color: #${mcolours.bright.black};
            border-radius: 6px;
            margin: 1px;
          }
          .modules-right {
            padding-right: 2px;
            margin: 4px;
          }
          #network,
          #wireplumber,
          #network,
          #bluetooth,
          #clock,
          #custom-powermenu,
          #custom-dnd {
            padding-right: 4px;
            padding-left: 4px;
            color: #${mcolours.primary.main};
            background-color: #${mcolours.bright.black};
            border-radius: 6px;
            margin: 1px;
          }
          tooltip {
            background: #${mcolours.primary.bg};
            color: #${mcolours.primary.fg};
            border: 1px solid #${mcolours.primary.main};
            border-radius: 6px;
          }
          tooltip label {
            color: #${mcolours.primary.fg};
          }
        '';
      };
    };
}
