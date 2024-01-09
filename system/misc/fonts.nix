{
  pkgs,
  lib,
  config,
  ...
}: {
  options.cute.misc.fonts.enable = lib.mkEnableOption "";
  config = lib.mkIf config.cute.misc.fonts.enable {
    fonts = {
      fonts = with pkgs; [
        lato
	quicksand
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
          sansSerif = ["Quicksand"];
          monospace = ["MonaspiceNe Nerd Font"];
        };
      };
    };
  };
}
