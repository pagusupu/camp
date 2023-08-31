{pkgs, ...}: let
  mountain-gtk = pkgs.stdenvNoCC.mkDerivation rec {
    pname = "mountain-gtk";
    version = "1";
    src = pkgs.fetchFromGitHub {
      owner = "mountain-theme";
      repo = "Mountain";
      rev = "master";
      sha256 = "sha256-lDLteOsKBGUyrkiKecqqrQLRRb9SlL5hJABrelUVITs=";
    };
    installPhase = ''
      mkdir -p $out/share/themes/mountain
      cp -r gtk/* $out/share/themes/mountain/
    '';
  };
in {
  gtk = {
    enable = true;
    theme = {
      package = mountain-gtk;
      name = "mountain";
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
  };
  qt = {
    enable = true;
    platformTheme = "gtk";
  };
}
