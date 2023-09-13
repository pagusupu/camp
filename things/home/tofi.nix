{
  mcolours,
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [../misc/colours.nix];
  options.local.programs.tofi = {
    enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.local.programs.tofi.enable {
    home = {
      packages = [pkgs.tofi];
      file.".config/tofi/config".text = ''
        font = "firacode"
        font-size = 16
        width = 300
        height = 500
        corner-radius = 7
        outline-width = 1
        outline-color = #${mcolours.primary.main}
        border-width = 0
        padding-top = 10
        padding-bottom = 0
        padding-left = 15
        padding-right = 0
        prompt-text = >>
        prompt-padding = 10
        background-color = #${mcolours.primary.bg}
        text-color = #${mcolours.primary.fg}
        selection-color = #${mcolours.primary.bg}
        selection-background = #${mcolours.primary.main}
        selection-background-padding = 8
        selection-background-corner-radius = 7
        result-spacing = 20
        drun-launch = true
        terminal = alactritty
        history = true
        fuzzy-match = true
        ascii-input = false
      '';
    };
  };
}
