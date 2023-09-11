{
  config,
  lib,
  mcolours,
  pkgs,
  ...
}: {
  imports = [../misc/colours.nix];
  options.local.programs.mako = {
    enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.local.programs.mako.enable {
    home = {
      packages = [pkgs.mako];
      file.".config/mako/config".text = ''
        layer=overlay
        default-timeout=5000
        ignore-timeout=1
        max-visible=2
        font=nunito 14
        anchor=bottom-right
        background-color=#${mcolours.primary.bg}
        text-color=#${mcolours.primary.fg}
        border-size=2
        border-color=#${mcolours.normal.red}
        border-radius=7
        margin=14
      '';
    };
  };
}
