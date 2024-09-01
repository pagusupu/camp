{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkMerge mkIf mkDefault;
  inherit (config.cute.programs.cli) nvim;
  inherit (config.cute.theme) name gtk;
in
  mkIf (name == "gruvbox") (mkMerge [
    (mkIf gtk {
      home-manager.users.pagu = {
        gtk = {
          theme = {
            package = pkgs.gruvbox-gtk-theme;
            name = mkDefault "Gruvbox-Light";
          };
          iconTheme = {
            package = pkgs.gruvbox-gtk-theme;
            name = mkDefault "Gruvbox-Light";
          };
        };
        home.pointerCursor = {
          package = pkgs.capitaine-cursors-themed;
          name = mkDefault "Capitaine Cursors (Gruvbox) - White";
        };
      };
      specialisation.dark.configuration = {
        home-manager.users.pagu = {
          gtk = {
            theme.name = "Gruvbox-Dark";
            iconTheme.name = "Gruvbox-Dark";
          };
          home.pointerCursor.name = "Capitaine Cursors (Gruvbox)";
        };
      };
    })
    (mkIf nvim {
      programs.nixvim = {
        colorschemes.gruvbox = {
          enable = true;
          settings.contrast = "hard";
        };
        extraPlugins = [pkgs.vimPlugins.lightline-gruvbox-vim];
      };
    })
  ])
