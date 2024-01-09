{
  config,
  lib,
  pkgs,
  ...
}: {
  options.hm.programs.tofi.enable = lib.mkEnableOption "";
  config = lib.mkIf config.hm.programs.tofi.enable {
    home.packages = [pkgs.tofi];
    home.file.".config/tofi/config".text = ''
      font = "MonaspiceNe Nerd Font"
      font-size = 16
      width = 300
      height = 500
      corner-radius = 7
      outline-width = 1
      outline-color = #${config.cute.colours.primary.main}
      border-width = 0
      padding-top = 10
      padding-left = 15
      prompt-text = >>
      prompt-padding = 10
      background-color = #${config.cute.colours.primary.bg}
      text-color = #${config.cute.colours.primary.fg}
      selection-color = #${config.cute.colours.primary.bg}
      selection-background = #${config.cute.colours.primary.main}
      selection-background-padding = 8
      selection-background-corner-radius = 7
      result-spacing = 20
      terminal = alactritty
    '';
  };
}
