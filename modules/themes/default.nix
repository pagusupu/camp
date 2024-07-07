{
  config,
  lib,
  _lib,
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
    ;
  inherit (config.cute.theme) gtk;
  inherit (config.cute.programs.cli) nvim;
in {
  options = {
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
        type = types.enum ["rose-pine" "gruvbox"];
      };
    };
  };
  config = mkMerge [
    (mkIf gtk {
      assertions = _lib.assertHm;
      home-manager.users.pagu = {
        qt = {
          enable = true;
          platformTheme.name = "gtk";
        };
        home.pointerCursor = {
          size = 24;
          gtk.enable = true;
          x11.enable = true;
        };
        gtk.enable = true;
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
        boot.loader.grub.configurationName = "Dark";
        environment.etc."specialisation".text = "Dark";
      };
    }
  ];
}
