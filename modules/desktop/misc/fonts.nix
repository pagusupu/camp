{
  pkgs,
  lib,
  config,
  ...
}: {
  options.cute.desktop.misc.fonts.enable = lib.mkEnableOption "";
  config = lib.mkIf config.cute.desktop.misc.fonts.enable {
    fonts = {
      fonts = with pkgs; [
        lato
        nerdfonts
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        noto-fonts-extra
      ];
      fontconfig = {
        enable = true;
        antialias = true;
        hinting.enable = true;
        hinting.autohint = true;
        subpixel.rgba = "rgb";
        defaultFonts = {
          serif = ["Lato"];
          sansSerif = ["Lato"];
          monospace = ["MonaspiceNe Nerd Font"];
        };
      };
    };
  };
}
