{
  config,
  lib,
  ...
}: {
  options.cute.home.waybar = lib.mkEnableOption "";
  config = lib.mkIf config.cute.home.waybar {
    home-manager.users.pagu = {
      programs.waybar = {
        enable = true;
        settings = let
          common = {
            layer = "top";
            width = 36;
            modules-left = ["hyprland/workspaces"];
            modules-right = ["clock"];
            clock.format = "{:%I \n%M \n%p}";
            "hyprland/workspaces" = {
              format = "{icon}";
              format-icons = {
                active = "";
                persistent = "";
              };
              persistent-workspaces."*" = 4;
            };
          };
        in {
          leftbar =
            common
            // {
              position = "left";
              margin-left = 6;
              output = ["DP-3"];
            };
          rightbar =
            common
            // {
              position = "right";
              margin-right = 6;
              output = ["HDMI-A-1"];
            };
        };
        style = with config.scheme; ''
          * {
            all: unset;
            font-family: "MonaspiceNe Nerd Font";
            font-size: 14px;
          }
          window#waybar {
            background: transparent;
          }
          .modules-left {
            margin-top: 6px;
          }
          .modules-right {
            margin-bottom: 6px;
          }
          #workspaces {
            background: #${base00};
            border-radius: 20px;
            padding: 5px 2px 5px 0px;
          }
          #workspaces button {
            color: #${base0B};
          }
          #workspaces button.empty {
            color: #${base05};
          }
          #clock {
            color: #${base05};
            background: #${base00};
            border-radius: 20px;
            padding: 7px 0px 6px 9px;
          }
        '';
      };
    };
  };
}
