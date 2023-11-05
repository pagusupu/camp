{
  pkgs,
  lib,
  config,
  ...
}: let
  sf-fonts = pkgs.stdenv.mkDerivation rec {
    pname = "sf-fonts";
    version = "1";
    pro = pkgs.fetchurl {
      url = "https://devimages-cdn.apple.com/design/resources/download/SF-Pro.dmg";
      sha256 = "sha256-nkuHge3/Vy8lwYx9z+pvsQZfzrNIP4K0OutpPl4yXn0=";
    };
    compact = pkgs.fetchurl {
      url = "https://devimages-cdn.apple.com/design/resources/download/SF-Compact.dmg";
      sha256 = "sha256-+Q4HInJBl3FLb29/x9utf7A55uh5r79eh/7hdQDdbSI=";
    };
    mono = pkgs.fetchurl {
      url = "https://devimages-cdn.apple.com/design/resources/download/SF-Mono.dmg";
      sha256 = "sha256-pqkYgJZttKKHqTYobBUjud0fW79dS5tdzYJ23we9TW4=";
    };
    ny = pkgs.fetchurl {
      url = "https://devimages-cdn.apple.com/design/resources/download/NY.dmg";
      sha256 = "sha256-XOiWc4c7Yah+mM7axk8g1gY12vXamQF78Keqd3/0/cE=";
    };
    nativeBuildInputs = [pkgs.p7zip];
    sourceRoot = ".";
    dontUnpack = true;
    installPhase = ''
      7z x ${pro}
      cd SFProFonts
      7z x 'SF Pro Fonts.pkg'
      7z x 'Payload~'
      mkdir -p $out/fontfiles
      mv Library/Fonts/* $out/fontfiles
      cd ..
      7z x ${mono}
      cd SFMonoFonts
      7z x 'SF Mono Fonts.pkg'
      7z x 'Payload~'
      mv Library/Fonts/* $out/fontfiles
      cd ..
      7z x ${compact}
      cd SFCompactFonts
      7z x 'SF Compact Fonts.pkg'
      7z x 'Payload~'
      mv Library/Fonts/* $out/fontfiles
      cd ..
      7z x ${ny}
      cd NYFonts
      7z x 'NY Fonts.pkg'
      7z x 'Payload~'
      mv Library/Fonts/* $out/fontfiles
      mkdir -p $out/usr/share/fonts/OTF $out/usr/share/fonts/TTF
      mv $out/fontfiles/*.otf $out/usr/share/fonts/OTF
      mv $out/fontfiles/*.ttf $out/usr/share/fonts/TTF
      rm -rf $out/fontfiles
    '';
  };
in {
  options.cute.misc.fonts = {
    enable = lib.mkEnableOption "font config";
  };
  config = lib.mkIf config.cute.misc.fonts.enable {
    fonts = {
      fonts = with pkgs; [
        nerdfonts
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        sf-fonts
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
