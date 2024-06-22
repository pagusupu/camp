{
  config,
  lib,
  _lib,
  ...
}: let
  inherit (lib) mkOption mkEnableOption types mkIf;
  inherit (types) str enum;
in {
  options = {
    colours.base16 = {
      A1 = mkOption {type = str;};
      A2 = mkOption {type = str;};
      A3 = mkOption {type = str;};
      A4 = mkOption {type = str;};
      A5 = mkOption {type = str;};
      A6 = mkOption {type = str;};
      A7 = mkOption {type = str;};
      A8 = mkOption {type = str;};
      B1 = mkOption {type = str;};
      B2 = mkOption {type = str;};
      B3 = mkOption {type = str;};
      B4 = mkOption {type = str;};
      B5 = mkOption {type = str;};
      B6 = mkOption {type = str;};
      B7 = mkOption {type = str;};
      B8 = mkOption {type = str;};
    };
    cute.theme = {
      gtk = mkEnableOption "";
      name = mkOption {
        default = "rose-pine";
        type = enum ["rose-pine"];
      };
    };
  };
  config = mkIf config.cute.theme.gtk {
    assertions = _lib.assertHm;
    home-manager.users.pagu.qt = {
      enable = true;
      platformTheme.name = "gtk";
    };
    programs.dconf.enable = true;
  };
}
