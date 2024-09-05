{
  config,
  lib,
  _lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf;
in {
  options.cute.desktop.waybar = mkEnableOption "";
  config = mkIf config.cute.desktop.waybar {
    assertions = _lib.assertHm "waybar";
    home-manager.users.pagu.programs.waybar = {
      enable = true;
      settings = let
        common = {
          layer = "top";
          modules-left = ["hyprland/workspaces"];
          modules-center = ["clock"];
          modules-right = ["custom/powermenu"];
          reload_style_on_change = true;
          width = 36;
          "hyprland/workspaces" = {
            format = "{icon}";
            format-icons = {
              active = "";
              persistent = "";
            };
            persistent-workspaces."*" = 4;
          };
          clock.format = "{:%I \n%M \n%p}";
          "custom/powermenu" = let
            menu = pkgs.writeShellScript "pm" ''
              op=$( echo -e "  Poweroff\n  Reboot\n  Lock\n  Logout" | ${lib.getExe pkgs.tofi} | awk '{print tolower($2)}' )
              case $op in poweroff) poweroff ;& reboot) reboot ;& lock) hyprlock ;; logout) hyprctl exit ;; esac
            '';
          in {
            on-click = "${menu}";
            format = "";
            tooltip = false;
          };
        };
      in {
        left =
          {
            position = "left";
            output = ["DP-3"];
          }
          // common;
        right =
          {
            position = "right";
            output = ["HDMI-A-1"];
          }
          // common;
      };
      style = with config.colours.base16;
      # css
        ''
          * {
            all: unset;
            font-family: monospace;
            font-size: 15px;
          }
          window#waybar {
            background: #${A1};
          }
          #workspaces {
            margin-top: 2px;
            padding: 5px 4px 5px 0px;
          }
          #workspaces button {
            color: #${B4};
          }
          #workspaces button.empty {
            color: #${A6};
          }
          #clock {
            color: #${A6};
            padding: 7px 0px 6px 9px;
          }
          #custom-powermenu {
            color: #${A6};
            font-size: 16px;
            margin-bottom: 4px;
            margin-right: 5px;
          }
        '';
    };
  };
}
