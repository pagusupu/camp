{pkgs}:
pkgs.stdenvNoCC.mkDerivation rec {
  pname = "everforest-cursors";
  version = "3212590527";
  src = pkgs.fetchurl {
    url = "https://github.com/talwat/everforest-cursors/releases/download/${version}/everforest-cursors-variants.tar.bz2";
    sha256 = "sha256-xXgtN9wbjbrGLUGYymMEGug9xEs9y44mq18yZVdbiuU=";
  };
  sourceRoot = ".";
  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/icons
    cp -r ./everforest-cursors* $out/share/icons
    runHook postInstall
  '';
}
