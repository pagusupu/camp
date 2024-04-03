{pkgs}:
pkgs.rustPlatform.buildRustPackage {
  pname = "localsend-rs";
  version = "0-unstable-2024-04-03";

  src = pkgs.fetchFromGitHub {
    owner = "zpp0196";
    repo = "localsend-rs";
    rev = "358c70ed7c293baaef97e3c9e4dc7cd6f5bc52b4";
    hash = "sha256-OUZ1QKV2VqTpkaGqcQyjFAYpcYmMQLU0Wvln+XO5nx0=";
  };

  cargoHash = "sha256-iBTuF5IHBPKphkecfFR1Hs4qyAFW0QuKkJbt+g6hwjw=";

  nativeBuildInputs = [pkgs.pkg-config];
  buildInputs = [pkgs.openssl];
}
