{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkMerge mkIf;
in {
  options.cute.programs.gui = {
    waybar = mkEnableOption "";
    wofi = mkEnableOption "";
  };
  config = let
    inherit (config.cute.programs.gui) waybar wofi;
  in
    mkMerge [
      (mkIf wofi {
        home-manager.users.pagu.programs.wofi = {
          enable = true;
          settings = {
            hide_scroll = true;
            insensitive = true;
            width = "10%";
            prompt = "";
            lines = 2;
          };
        };
      })
      (mkIf waybar {
        home-manager.users.pagu.programs.waybar = {
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
              {
                position = "left";
                margin-left = 6;
                output = ["DP-3"];
              }
              // common;
            rightbar =
              {
                position = "right";
                margin-right = 6;
                output = ["HDMI-A-1"];
              }
              // common;
          };
          style = let
            inherit (config) scheme;
          in ''
            * {
              all: unset;
              font-family: "MonaspiceNe Nerd Font";
              font-size: 14px;
            }
            window#waybar {
              background: transparent;
            }
            #workspaces {
              background: #${scheme.base00};
              border-radius: 20px;
              padding: 5px 2px 5px 0px;
              margin-top: 6px;
            }
            #workspaces button {
              color: #${scheme.base0B};
            }
            #workspaces button.empty {
              color: #${scheme.base05};
            }
            #clock {
              color: #${scheme.base05};
              background: #${scheme.base00};
              border-radius: 20px;
              padding: 7px 0px 6px 9px;
              margin-bottom: 6px;
            }
          '';
        };
      })
    ];
}
