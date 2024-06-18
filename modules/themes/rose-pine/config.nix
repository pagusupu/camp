{
  config,
  lib,
  _lib,
  pkgs,
  ...
}: let
  inherit (lib) mkMerge mkIf mkDefault;
  inherit (config.cute.programs.cli) nvim;
  inherit (config.cute.theme) gtk;
  dawn = "rose-pine-dawn";
  moon = "rose-pine-moon";
  cfg = config.cute.theme.name;
in
  mkMerge [
    (mkIf gtk {
      assertions = _lib.assertHm;
      home-manager.users.pagu = mkIf (cfg == "rose-pine") {
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
          name = mkDefault "BreezeX-RosePine-Linux";
          size = 24;
          gtk.enable = true;
          x11.enable = true;
        };
      };
      specialisation.dark.configuration.home-manager.users.pagu = mkIf (cfg == "rose-pine") {
        gtk = {
          theme.name = moon;
          iconTheme.name = moon;
        };
        home.pointerCursor.name = "BreezeX-RosePineDawn-Linux";
      };
    })
    (mkIf nvim {
      programs.nixvim.colorschemes.rose-pine = mkIf (cfg == "rose-pine") {
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
  ]
