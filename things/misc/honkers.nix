let
  aagl-gtk-on-nix = import (builtins.fetchTarball {
    url = "https://github.com/ezKEa/aagl-gtk-on-nix/archive/main.tar.gz";
    sha256 = "0bl323dkil10z3kwf43vsiwn11i7argcj0a16z3bjmcjp4q890sc";
  });
in {
  home.packages = [aagl-gtk-on-nix.the-honkers-railway-launcher];
}
