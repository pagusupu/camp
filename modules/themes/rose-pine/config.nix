{
  config,
  lib,
  _lib,
  pkgs,
  ...
}: let
  inherit (lib) mkMerge mkIf mkDefault;
  inherit (config.cute.programs.cli) nvim;
  inherit (config.cute.programs.gui) vscode;
  inherit (config.cute.theme) name gtk;
in
  mkIf (name == "rose-pine") (mkMerge [
    (mkIf gtk {
      assertions = _lib.assertHm;
      home-manager.users.pagu = {
        gtk = {
          theme = {
            package = pkgs.rose-pine-gtk-theme;
            name = mkDefault "rose-pine-dawn";
          };
          iconTheme = {
            package = pkgs.rose-pine-icon-theme;
            name = mkDefault "rose-pine-dawn";
          };
        };
        home.pointerCursor = {
          package = pkgs.rose-pine-cursor;
          name = mkDefault "BreezeX-RosePine-Linux";
        };
      };
      specialisation.dark.configuration = {
        home-manager.users.pagu = {
          gtk = {
            theme.name = "rose-pine-moon";
            iconTheme.name = "rose-pine-moon";
          };
          home.pointerCursor.name = "BreezeX-RosePine-linux";
        };
      };
    })
    (mkIf nvim {
      programs.nixvim.colorschemes.rose-pine = {
        enable = true;
        settings = {
          dark_variant = "moon";
          styles = {
            italic = false;
            transparency = false;
          };
          variant = "auto";
        };
      };
      specialisation.dark.configuration = {
        programs.nixvim.plugins.lightline.colorscheme = "rosepine_moon";
      };
    })
    (mkIf vscode {
      assertions = _lib.assertHm;
      home-manager.users.pagu.programs.vscode = {
        extensions = [pkgs.vscode-extensions.mvllow.rose-pine];
        userSettings."workbench.colorTheme" = mkDefault "Rosé Pine Dawn (no italics)";
      };
      specialisation.dark.configuration = {
        home-manager.users.pagu.programs.vscode = {
          userSettings."workbench.colorTheme" = "Rosé Pine Moon (no italics)";
        };
      };
    })
  ])
