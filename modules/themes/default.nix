{
  config,
  lib,
  _lib,
  pkgs,
  ...
}: let
  inherit (lib) mkOption types mkEnableOption mkMerge mkIf mkDefault mkOverride;
  inherit (config.cute.theme) gtk;
  inherit (config.cute.programs.cli) nvim;
in {
  options = {
    # i forgot about this ill fix it eventually
    colours.base16 = let
      str = mkOption {type = types.str;};
    in {
      A1 = str;
      A2 = str;
      A3 = str;
      A4 = str;
      A5 = str;
      A6 = str;
      A7 = str;
      A8 = str;
      B1 = str;
      B2 = str;
      B3 = str;
      B4 = str;
      B5 = str;
      B6 = str;
      B7 = str;
      B8 = str;
    };
    cute.theme = {
      gtk = mkEnableOption "";
      name = mkOption {
        default = "everforest";
        type = types.enum ["everforest" "rose-pine"];
      };
    };
  };
  config = mkMerge [
    (mkIf gtk {
      assertions = _lib.assertHm "gtk";
      home-manager.users.pagu = {
        gtk = {
          enable = true;
          iconTheme = {
            package = mkOverride 1111 pkgs.adwaita-icon-theme;
            name = mkOverride 1111 "Adwaita";
          };
        };
        qt = {
          enable = true;
          style = {inherit (config.home-manager.users.pagu.gtk.theme) package name;};
        };
        home.pointerCursor = {
          package = mkOverride 1111 pkgs.phinger-cursors;
          name = mkOverride 2222 "phinger-cursors-light";
          size = 24;
          gtk.enable = true;
          x11.enable = true;
        };
      };
      specialisation.dark.configuration = {
        home-manager.users.pagu.home.pointerCursor.name = mkOverride 1111 "phinger-cursors-dark";
      };
      programs.dconf.enable = true;
    })
    (mkIf nvim {
      programs.nixvim.opts.background = mkDefault "light";
      specialisation.dark.configuration = {
        programs.nixvim.opts.background = "dark";
      };
    })
    {
      specialisation.dark.configuration = {
        boot.loader.grub.configurationName = "dark";
        environment.etc."specialisation".text = "dark";
      };
    }
  ];
}
