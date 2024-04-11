{pkgs}:
pkgs.stdenvNoCC.mkDerivation {
  pname = "sora";
  version = "1";
  src = pkgs.fetchFromGitHub {
    owner = "sora-xor";
    repo = "sora-font";
    rev = "7f9a9c5d0ccd1c099cfac420aa27133df1c5fdc4";
    sha256 = "sha256-35rMWYpO2tv0ZUYVskff6Gl9fUjTeGBA5AvcGnvFp40=";
  };
  installPhase = ''
    mkdir -p $out/share/fonts/OTF $out/share/fonts/TTF
    cp -R $src/fonts/otf $out/share/fonts/OTF
    cp -R $src/fonts/ttf/v2.1beta $out/share/fonts/TTF
  '';
}
