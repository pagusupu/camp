{
  config,
  lib,
  _lib,
  pkgs,
  ...
}: let
  inherit
    (lib)
    mkOption
    types
    mkEnableOption
    mkMerge
    mkIf
    mkDefault
    mkOverride
    ;
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
        default = "rose-pine";
        type = types.enum ["everforest" "graphite" "rose-pine"];
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
            package = mkOverride 1001 pkgs.adwaita-icon-theme;
            name = mkOverride 1001 "Adwaita";
          };
        };
        qt = {
          enable = true;
          style = {
            package = pkgs.adwaita-qt;
            name = mkDefault "adwaita";
          };
        };
        home.pointerCursor = {
          package = mkOverride 1001 pkgs.posy-cursors;
          name = mkOverride 1002 "Posy_Cursor_Mono";
          size = 24;
          gtk.enable = true;
          x11.enable = true;
        };
      };
      programs.dconf.enable = true;
      specialisation.dark.configuration = {
        home-manager.users.pagu = {
          home.pointerCursor.name = mkOverride 1001 "Posy_Cursor_Mono_Black";
          qt.style.name = "adwaita-dark";
        };
      };
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
