{
  pkgs,
  lib,
  config,
  ...
}: {
  options.cute.misc.fonts = {
    enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.cute.misc.fonts.enable {
    fonts = {
      fonts = with pkgs; [
        nerdfonts
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
	noto-fonts-extra
        (pkgs.callPackage ../../../pkgs/sf.nix {})
        (google-fonts.override {fonts = ["Lato" "Nunito"];})
      ];
      fontconfig = {
        enable = true;
        antialias = true;
        hinting.enable = true;
        hinting.autohint = true;
        subpixel.rgba = "rgb";
        defaultFonts = {
          sansSerif = ["Nunito"];
          serif = ["Lato"];
          monospace = ["SF Mono"];
        };
      };
    };
  };
}
