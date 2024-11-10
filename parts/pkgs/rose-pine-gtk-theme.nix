{pkgs}:
pkgs.stdenvNoCC.mkDerivation {
  pname = "rose-pine-gtk-theme";
  version = "unstable-2024-10-08";
  src = pkgs.fetchFromGitHub {
    owner = "rose-pine";
    repo = "gtk";
    rev = "d0d7815f0af2facd3157e005cd7c606d4f28d881";
    hash = "sha256-vCWs+TOVURl18EdbJr5QAHfB+JX9lYJ3TPO6IklKeFE=";
  };
  buildInputs = [pkgs.gtk_engines pkgs.gnome-themes-extra];
  propagatedUserEnvPkgs = [pkgs.gtk-engine-murrine];
  dontBuild = true;
  installPhase = ''
    runHook preInstall
    mkdir -p $out/share/themes/rose-pine{,-dawn,-moon}/gtk-4.0
    variants=("rose-pine" "rose-pine-dawn" "rose-pine-moon")
    for n in "''${variants[@]}"; do
      cp -r $src/gtk3/"''${n}"-gtk/* $out/share/themes/"''${n}"
      cp -r $src/gtk4/"''${n}".css $out/share/themes/"''${n}"/gtk-4.0/gtk.css
    done
    runHook postInstall
  '';
}
