{
  config,
  lib,
  _lib,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.cute.desktop.waybar = mkEnableOption "";
  config = mkIf config.cute.desktop.waybar {
    assertions = _lib.assertHm;
    home-manager.users.pagu.programs.waybar = {
      enable = true;
      settings = let
        hypr = {
          layer = "top";
          width = 36;
          modules-left = ["hyprland/workspaces"];
          modules-center = ["clock"];
          modules-right = ["network"];
          "hyprland/workspaces" = {
            format = "{icon}";
            format-icons = {
              active = "";
              persistent = "";
            };
            persistent-workspaces."*" = 4;
          };
          clock.format = "{:%I \n%M \n%p}";
          network = {
            format = "";
            format-ethernet = "<span size='16pt'>󰌗</span>";
            format-wifi = "";
            format-linked = "";
            interval = "20";
            tooltip = false;
            interface = "${config.cute.net.interface}";
          };
        };
      in {
        hyprleft =
          {
            position = "left";
            output = ["DP-3"];
          }
          // hypr;
        hyprright =
          {
            position = "right";
            output = ["HDMI-A-1"];
          }
          // hypr;
        #niri = {};
      };
      style = let
        inherit (config) scheme;
      in ''
        * {
          all: unset;
          font-family: monospace;
          font-size: 15px;
        }
        window#waybar {
          background: #${scheme.base00};
        }
        #workspaces {
          margin-top: 2px;
          padding: 5px 4px 5px 0px;
        }
        #workspaces button {
          color: #${scheme.base0B};
        }
        #workspaces button.empty {
          color: #${scheme.base05};
        }
        #clock {
          color: #${scheme.base05};
          padding: 7px 0px 6px 9px;
        }
        #network {
          color: #${scheme.base05};
          margin-bottom: 2px;
          padding-right: 3px;
        }
      '';
    };
  };
}
