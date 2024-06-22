{
  config,
  lib,
  _lib,
  ...
}: {
  options = {
    colours.base16 = let
      str = lib.mkOption {type = lib.types.str;};
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
      gtk = lib.mkEnableOption "";
      name = lib.mkOption {
        default = "rose-pine";
        type = lib.types.enum ["rose-pine"];
      };
    };
  };
  config = lib.mkIf config.cute.theme.gtk {
    assertions = _lib.assertHm;
    home-manager.users.pagu.qt = {
      enable = true;
      platformTheme.name = "gtk";
    };
    programs.dconf.enable = true;
  };
}
