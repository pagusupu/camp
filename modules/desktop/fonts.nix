{
  pkgs,
  lib,
  config,
  ...
}: {
  options.cute.desktop.fonts = lib.mkEnableOption "";
  config = lib.mkIf config.cute.desktop.fonts {
    fonts = {
      packages = with pkgs; [
        lato
        nerdfonts
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        noto-fonts-extra
        (pkgs.callPackage ../../pkgs/sora.nix {})
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
