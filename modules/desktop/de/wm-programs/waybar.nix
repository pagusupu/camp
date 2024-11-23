{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.desktop.wm.waybar = cutelib.mkEnable;
  config = lib.mkIf config.cute.desktop.wm.waybar {
    assertions = cutelib.assertHm "waybar";
    home-manager.users.pagu.programs.waybar = {
      enable = true;
      settings = let
        common = {
          reload_style_on_change = true;
          layer = "top";
          height = 320;
          width = 36;

          modules-left = [ "hyprland/workspaces" ];
          modules-center = [ "clock" ];
          modules-right = [ "custom/term" "custom/launch" "custom/power" ];

          "hyprland/workspaces" = {
            format = "{icon}";
            format-icons = {
              active = "";
              persistent = "";
            };
            persistent-workspaces."*" = 4;
          };
          "custom/term" = {
            on-click = "alacritty";
            format = "";
            tooltip = false;
          };
          "custom/launch" = {
            on-click = "wofi";
            format = "";
            tooltip = false;
          };
          "custom/power" = {
            on-click = "wlogout -b 2";
            format = "";
            tooltip = false;
          };
          clock.format = "{:%I \n%M \n%p}";
        };
      in {
        left =
          {
            position = "left";
            output = [ "DP-3" ];
            margin-left = 6;
          }
          // common;
        right =
          {
            position = "right";
            output = [ "HDMI-A-1" ];
            margin-right = 6;
          }
          // common;
      };
      style = with config.wh.colours;
      # css
        ''
          * {
            all: unset;
            font-family: monospace;
            font-size: 15px;
          }
          window#waybar {
            background: ${base};
            border-radius: 6px;
          }
          #workspaces {
            margin-top: 2px;
            padding: 5px 4px 5px 0px;
          }
          #workspaces button {
            color: ${iris};
          }
          #workspaces button.empty {
            color: ${text};
          }
          #clock {
            color: ${text};
            padding: 7px 0px 6px 9px;
          }
          #custom-term {
            color: ${text};
            font-size: 18px;
            margin-right: 6px;
          }
          #custom-launch {
            color: ${text};
            font-size: 17px;
            margin-right: 6px;
          }
          #custom-power {
            color: ${text};
            font-size: 16px;
            margin-bottom: 4px;
            margin-right: 5px;
          }
        '';
    };
  };
}
