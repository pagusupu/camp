{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkDefault;
  inherit (config.cute.programs.cli) nvim;
  inherit (config.cute.themes) gtk;
  dawn = "rose-pine-dawn";
  moon = "rose-pine-moon";
in
  mkIf config.cute.themes.rose-pine {
    home-manager.users.pagu = mkIf gtk {
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
      home = {
        pointerCursor = {
          package = pkgs.rose-pine-cursor;
          name = mkDefault "BreezeX-RosePine-Linux";
          size = 24;
          gtk.enable = true;
          x11.enable = true;
        };
      };
    };
    programs.nixvim = mkIf nvim {
      plugins.lightline.colorscheme = mkDefault "rosepine";
      colorschemes.rose-pine = {
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
    };
    specialisation.dark.configuration = {
      programs.nixvim.plugins.lightline.colorscheme = mkIf nvim "rosepine_moon";
      home-manager.users.pagu = mkIf gtk {
        gtk = {
          theme.name = moon;
          iconTheme.name = moon;
        };
        home.pointerCursor.name = "BreezeX-RosePineDawn-Linux";
      };
    };
  }
