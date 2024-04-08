{
  config,
  lib,
  pkgs,
  ...
}: {
  options.cute.home = {
    mako = lib.mkEnableOption "";
    waybar = lib.mkEnableOption "";
    wofi = lib.mkEnableOption "";
  };
  config = let
    inherit (config.cute.home) mako waybar wofi;
  in {
    programs.waybar.enable = lib.mkIf waybar true;
    environment.systemPackages = builtins.attrValues {inherit (pkgs) mako wofi;};
    home.file = {
      "waybar-config" = {
        target = ".config/waybar/config";
        text = let
          common = ''
            "layer": "top",
            "width": 36,
            "modules-left": ["hyprland/workspaces"],
            "modules-right": ["clock"],
            "clock": {
            "format": "{:%I \n%M \n%p}"
            },
            "hyprland/workspaces": {
            "format": "{icon}",
              "format-icons": {
                "active": "",
                "persistent": ""
              },
              "persistent-workspaces": { "*": 4 },
            },
          '';
        in ''
          [
            {
              ${common}
              "position": "left",
              "margin-left": 6,
              "output": [ "DP-3" ]
            },
            {
              ${common}
              "position": "right",
              "margin-right": 6,
              "output": [ "HDMI-A-1" ]
            }
          ]
        '';
      };
      "waybar-style" = {
        target = ".config/waybar/style.css";
        text = let
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
      "mako" = lib.mkIf mako {
        target = ".config/mako/config";
        text = let
          inherit (config) scheme;
        in ''
          anchor=bottom-left
          layer=top
          max-visible=3
          default-timeout=3
          ignore-timeout=false
          markup=true
          actions=true
          icons=true
          max-icon-size=64
          format=<b>%s</b>\n%b
          font=monospace 10
          sort=-time
          width=300
          height=100
          margin=14
          padding=5
          border-size=2
          border-radius=6
          border-color=${scheme.base0D}
          background-color=${scheme.base00}
          text-color=${scheme.base05}
          progress-color=over ${scheme.base0D}
        '';
      };
      "wofi" = lib.mkIf wofi {
        target = ".config/wofi/config";
        text = ''
          hide_scroll=true
          insensitive=true
          lines=7
          prompt=
          width=10%
        '';
      };
    };
  };
}
