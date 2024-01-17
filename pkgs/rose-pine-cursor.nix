{pkgs}:
pkgs.stdenvNoCC.mkDerivation rec {
  pname = "rose-pine-cursor";
  version = "1.1.0";

  src = pkgs.fetchFromGitHub {
    owner = "rose-pine";
    repo = "cursor";
    rev = "v${version}";
    sha256 = "YQcxaLwdoueSJjyLAv0YTn4aCq9ZlIUbro0SGef+Rxw=";
  };

  sourceRoot = "./source";

  buildInputs = [
    pkgs.clickgen
    pkgs.python311Packages.attrs
  ];

  buildPhase = ''
    mkdir -p $out/share/icons
    ctgen build.toml -p 'x11' -d 'bitmaps/BreezeX-RoséPine' -n 'BreezeX-RosePine' -o $out/share/icons
    ctgen build.toml -p 'x11' -d 'bitmaps/BreezeX-RoséPineDawn' -n 'BreezeX-RosePineDawn' -o $out/share/icons
  '';
}
