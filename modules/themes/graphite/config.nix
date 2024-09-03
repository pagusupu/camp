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
  mkIf (name == "graphite") (mkMerge [
    (mkIf gtk {
      home-manager.users.pagu = {
        gtk.theme = {
          package = pkgs.graphite-gtk-theme;
          name = mkDefault "Graphite-Light";
        };
        home.pointerCursor = {
          package = pkgs.graphite-cursors;
          name = mkDefault "graphite-light";
        };
      };
      specialisation.dark.configuration = {
        home-manager.users.pagu = {
          gtk.theme.name = "Graphite-Dark";
          home.pointerCursor.name = "graphite-dark";
        };
      };
    })
    (mkIf nvim {
      programs.nixvim = {
        colorschemes.base16 = {
          enable = true;
          colorscheme = with config.colours.base16; {
            base00 = "#${A1}";
            base01 = "#${A1}";
            base02 = "#${A3}";
            base03 = "#${A4}";
            base04 = "#${A5}";
            base05 = "#${A6}";
            base06 = "#${A7}";
            base07 = "#${A8}";
            base08 = "#${B1}";
            base09 = "#${B2}";
            base0A = "#${B3}";
            base0B = "#${B4}";
            base0C = "#${B5}";
            base0D = "#${B4}";
            base0E = "#${B7}";
            base0F = "#${B8}";
          };
        };
        plugins.lualine.theme = "base16";
      };
    })
  ])
