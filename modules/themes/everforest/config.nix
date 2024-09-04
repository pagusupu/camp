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
        home.pointerCursor = {
          package = pkgs.callPackage ../../../misc/pkgs/everforest-cursors.nix {};
          name = mkDefault "everforest-cursors-light";
        };
      };
      specialisation.dark.configuration = {
        home-manager.users.pagu = {
          gtk = {
            theme.name = "Everforest-Dark-BL-LB";
            iconTheme.name = "Everforest-Dark";
          };
          home.pointerCursor.name = "everforest-cursors";
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
