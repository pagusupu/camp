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
        nerdfonts
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        noto-fonts-extra
	(google-fonts.override { fonts = ["Sora"];})
      ];
      fontconfig = {
        enable = true;
        antialias = true;
        hinting.enable = true;
        hinting.autohint = true;
        subpixel.rgba = "rgb";
        defaultFonts = {
          serif = ["Lato"];
          sansSerif = ["Sora"];
          monospace = ["MonaspiceNe Nerd Font"];
        };
      };
    };
  };
}
