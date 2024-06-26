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
          plugins = with inputs.anyrun.packages.${pkgs.system}; [
            applications
            rink
          ];
          closeOnClick = true;
          hideIcons = true;
          showResultsImmediately = true;
        };
        extraConfigFiles."applications.ron".text = ''
          Config(
            desktop_actions: false,
            max_entries: 3,
            terminal: Some("alacritty"),
          )
        '';
        extraCss = with config.colours.base16;
        # css
          ''
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
              background: #${A1};
              color: #${A6};
              border-width: 3px;
              border-radius: 6px;
              margin-bottom: 6px;
              margin-top: 14px;
            }
            list#main, list#main:hover {
              background: #${A3};
              color: #${A6};
              border-radius: 6px;
            }
            box#match:hover {
              color: #${A1};
              background: #${B6};
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
