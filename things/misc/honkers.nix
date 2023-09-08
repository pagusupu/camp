let
  aagl-gtk-on-nix = import (builtins.fetchTarball {
    url = "https://github.com/ezKEa/aagl-gtk-on-nix/archive/main.tar.gz";
    sha256 = "04yk09kmki2pbcm69cblnsbydq0faldc30k0rh2wpkgs5kkq0l51";
  });
in {
  home.packages = [aagl-gtk-on-nix.the-honkers-railway-launcher];
}
