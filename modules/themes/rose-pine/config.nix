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
  dawn = "rose-pine-dawn";
  moon = "rose-pine-moon";
in
  mkIf (name == "rose-pine") (mkMerge [
    (mkIf gtk {
      assertions = _lib.assertHm;
      home-manager.users.pagu = {
        gtk = {
          enable = true;
          theme = {
            package = pkgs.rose-pine-gtk-theme;
            name = mkDefault dawn;
          };
          iconTheme = {
            package = pkgs.rose-pine-icon-theme;
            name = mkDefault dawn;
          };
        };
        home.pointerCursor = {
          package = pkgs.rose-pine-cursor;
          name = mkDefault "BreezeX-RosePineDawn-Linux";
          size = 24;
          gtk.enable = true;
          x11.enable = true;
        };
      };
      specialisation.dark.configuration.home-manager.users.pagu = {
        gtk = {
          theme.name = moon;
          iconTheme.name = moon;
        };
        home.pointerCursor.name = "BreezeX-RosePine-Linux";
      };
    })
    (mkIf vscode {
      home-manager.users.pagu.programs.vscode = {
        extensions = [pkgs.vscode-extensions.mvllow.rose-pine];
        userSettings = {
          "workbench.colorTheme" = mkDefault "Rosé Pine Dawn (no italics)";
        };
      };
      specialisation.dark.configuration.home-manager.users.pagu = {
        programs.vscode.userSettings = {
          "workbench.colorTheme" = "Rosé Pine Moon (no italics)";
        };
      };
    })
    (mkIf nvim {
      programs.nixvim.colorschemes.rose-pine = {
        enable = true;
        settings = {
          variant = "auto";
          dark_variant = "moon";
          styles = {
            italic = false;
            transparency = false;
          };
        };
      };
    })
  ])
