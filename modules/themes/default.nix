{
  config,
  lib,
  _lib,
  inputs,
  ...
}: {
  imports = [inputs.base16.nixosModule];
  options.cute.theme = {
    gtk = lib.mkEnableOption "";
    name = lib.mkOption {
      default = "rose-pine";
      type = lib.types.enum ["rose-pine"];
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
