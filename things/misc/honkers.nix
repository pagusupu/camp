let
  aagl-gtk-on-nix = import (builtins.fetchTarball { 
    url = "https://github.com/ezKEa/aagl-gtk-on-nix/archive/main.tar.gz";
    sha256 = "1hwzwwrd11apvmrgrh3nfb8mgg1gpvn6xzf5rmaf6jr6inpy5948";
  });
in 
{
  home.packages = [aagl-gtk-on-nix.the-honkers-railway-launcher];
}
