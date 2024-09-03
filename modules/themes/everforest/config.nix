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
  mkIf (name == "everforest") (mkMerge [
    (mkIf gtk {
      home-manager.users.pagu = {
        gtk = {
          theme = {
            package = pkgs.everforest-gtk-theme;
            name = mkDefault "Everforest-Light-BL-LB";
          };
          iconTheme = {
            package = pkgs.everforest-gtk-theme;
            name = mkDefault "everforest_light";
          };
        };
      };
      specialisation.dark.configuration = {
        home-manager.users.pagu.gtk = {
          theme.name = "Everforest-Dark-BL-LB";
          iconTheme.name = "Everforest-Dark";
        };
      };
    })
    (mkIf nvim {
      programs.nixvim = {
        colorschemes.everforest.enable = true;
        plugins.lualine.theme = "everforest";
      };
    })
  ])
