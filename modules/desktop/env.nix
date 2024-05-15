{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkMerge mkIf;
in {
  options.cute.desktop.env = {
    anyrun = mkEnableOption "";
    waybar = mkEnableOption "";
    misc = mkEnableOption "";
  };
  config = let
    inherit (config.cute.desktop.env) anyrun waybar misc;
  in
    mkMerge [
      (mkIf anyrun {
        home-manager.users.pagu = let
          inherit (inputs.anyrun) homeManagerModules packages;
        in {
          imports = [homeManagerModules.default];
          programs.anyrun = {
            enable = true;
            config = {
              plugins = builtins.attrValues {
                inherit
                  (packages.${pkgs.system})
                  applications
                  rink
                  ;
              };
              closeOnClick = true;
              hideIcons = true;
              showResultsImmediately = true;
            };
            extraCss = let
              inherit (config) scheme;
            in ''
              * {
                font-family: monospace;
                font-size: 16px;
              }
              #match {
                border-radius: 6px;
              }
              #window {
                background-color: transparent;
              }
              #entry {
                background: #${scheme.base00};
                color: #${scheme.base05};
                border-width: 3px;
                border-radius: 6px;
                margin-bottom: 6px;
                margin-top: 14px;
              }
              list#main, list#main:hover {
                background: #${scheme.base02};
                color: #${scheme.base05};
                border-radius: 6px;
              }
              box#match:hover {
                color: #${scheme.base00};
                background: #${scheme.base0D};
              }
              row#plugin, row#plugin:hover {
                background: none;
                outline: none;
              }
            '';
          };
        };
        nix.settings = {
          substituters = ["https://anyrun.cachix.org"];
          trusted-public-keys = ["anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="];
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
              font-family: monospace;
              font-size: 14px;
            }
            window#waybar {
              background: transparent;
            }
            #workspaces {
              background: #${scheme.base00};
              border-radius: 20px;
              margin-top: 6px;
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
              background: #${scheme.base00};
              border-radius: 20px;
              margin-bottom: 6px;
              padding: 7px 0px 6px 9px;
            }
          '';
        };
      })
      (mkIf misc {
        home-manager.users.pagu = {
          home.packages = builtins.attrValues {
            inherit
              (pkgs)
              grimblast
              imv
              mako
              rwpspread
              swaybg
              wl-clipboard
              ;
          };
          xdg.userDirs = let
            d = "/home/pagu/";
          in {
            desktop = d + ".local/misc/desktop";
            documents = d + "documents";
            download = d + "downloads";
            pictures = d + "pictures";
            videos = d + "pictures/videos";
          };
        };
      })
    ];
}
