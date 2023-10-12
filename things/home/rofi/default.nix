{
  lib,
  config,
  ...
}: {
  options.cute.programs.rofi = {
    enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.cute.programs.rofi.enable {
    programs.rofi = {
      enable = true;
      terminal = "alacritty";
      theme = "~/Nix/things/home/rofi/theme.rasi";
    };
  };
}
