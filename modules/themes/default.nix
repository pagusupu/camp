{
  config,
  lib,
  _lib,
  inputs,
  ...
}: {
  imports = [inputs.base16.nixosModule];
  options.cute.themes = {
    gtk = lib.mkEnableOption "";
    rose-pine = lib.mkOption {
      default = true;
      type = lib.types.bool;
    };
  };
  config = lib.mkIf config.cute.themes.gtk {
    assertions = _lib.assertHm;
    home-manager.users.pagu.qt = {
      enable = true;
      platformTheme.name = "gtk";
    };
    programs.dconf.enable = true;
  };
}
