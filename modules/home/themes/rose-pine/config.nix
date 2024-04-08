{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkDefault;
  inherit (config.cute.common) nvim;
  inherit (config.cute.home) gtk;
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
    programs = {
      nixvim.colorschemes.rose-pine = mkIf nvim {
        enable = true;
        disableItalics = true;
        style = mkDefault "dawn";
      };
    };
    specialisation.dark.configuration = {
      programs.nixvim.colorschemes.rose-pine = mkIf nvim {
        style = "moon";
      };
      home-manager.users.pagu = mkIf gtk {
        gtk = {
          theme.name = moon;
          iconTheme.name = moon;
        };
        home.pointerCursor.name = "BreezeX-RosePineDawn-Linux";
      };
    };
  }
