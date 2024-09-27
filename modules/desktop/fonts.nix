{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}: {
  options.cute.desktop.fonts = cutelib.mkEnable;
  config = lib.mkIf config.cute.desktop.fonts {
    fonts = {
      packages = with pkgs; [
        (google-fonts.override {
          fonts = [
            "Lato"
            "Nunito"
          ];
        })
        (nerdfonts.override {
          fonts = [
            "JetBrainsMono"
            "NerdFontsSymbolsOnly"
          ];
        })
        dejavu_fonts
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        noto-fonts-extra
      ];
      fontconfig = {
        enable = true;
        defaultFonts = {
          emoji = ["Noto Color Emoji"];
          monospace = ["JetBrainsMono Nerd Font"];
          sansSerif = ["Nunito"];
          serif = ["Lato"];
        };
        subpixel.rgba = "rgb";
      };
    };
  };
}
