{
  config,
  lib,
  _lib,
  inputs,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkMerge mkIf;
  inherit (_lib) assertHm;
in {
  options.cute.desktop.env = {
    anyrun = mkEnableOption "";
    misc = mkEnableOption "";
    swaync = mkEnableOption "";
  };
  config = let
    inherit (config.cute.desktop.env) anyrun misc swaync;
  in
    mkMerge [
      (mkIf anyrun {
        assertions = assertHm;
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
      (mkIf misc {
        assertions = assertHm;
        home-manager.users.pagu = {
          home.packages = builtins.attrValues {
            inherit
              (pkgs)
              grimblast
              imv
              rwpspread
              swaybg
              wl-clipboard
              ;
          };
          xdg = {
            enable = true;
            userDirs = let
              d = "/home/pagu/";
            in {
              enable = true;
              desktop = d + ".local/misc/desktop";
              documents = d + "documents";
              download = d + "downloads";
              pictures = d + "pictures";
              videos = d + "pictures/videos";
            };
          };
        };
      })
      (mkIf swaync {
        assertions = assertHm;
        home-manager.users.pagu.services.swaync = {
          enable = true;
          settings = {
            positionX = "left";
            positionY = "bottom";
            timeout = "3";
            timeout-low = "3";
          };
        };
      })
    ];
}
