{
  config,
  lib,
  mcolours,
  pkgs,
  ...
}: {
  imports = [../misc/user/colours.nix];
  options.cute.programs.mako = {
    enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.cute.programs.mako.enable {
    home = {
      packages = [pkgs.mako];
      file.".config/mako/config".text = ''
        layer=overlay
        default-timeout=5000
        ignore-timeout=1
        max-visible=2
        anchor=bottom-right
        margin=16
        font=nunito 14
        text-color=#${mcolours.primary.fg}
        background-color=#${mcolours.primary.bg}
        border-color=#${mcolours.normal.red}
        border-size=2
        border-radius=7
        [mode=do-not-disturb]
        invisible=1
      '';
    };
  };
}
