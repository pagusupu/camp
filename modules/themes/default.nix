{
  config,
  lib,
  inputs,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types mkIf;
in {
  imports = [inputs.base16.nixosModule];
  options.cute.themes = {
    gtk = mkEnableOption "";
    rose-pine = mkOption {
      type = types.bool;
      default = true;
    };
  };
  config = mkIf config.cute.themes.gtk {
    home-manager.users.pagu.qt = {
      enable = true;
      platformTheme.name = "gtk";
    };
    programs.dconf.enable = true;
  };
}
