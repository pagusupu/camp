{
  config,
  lib,
  _lib,
  inputs,
  pkgs,
  ...
}: {
  options.cute.desktop.anyrun = lib.mkEnableOption "";
  config = lib.mkIf config.cute.desktop.anyrun {
    assertions = _lib.assertHm;
    home-manager.users.pagu = {
      imports = [inputs.anyrun.homeManagerModules.default];
      programs.anyrun = {
        enable = true;
        config = {
          plugins = builtins.attrValues {
            inherit
              (inputs.anyrun.packages.${pkgs.system})
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
  };
}
