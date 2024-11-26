{pkgs, ...}:
pkgs.hyprlandPlugins.hypr-dynamic-cursors.overrideAttrs (
  _prev: {
    pname = "hypr-dynamic-cursors";
    version = "unstable-2024-11-18";
    src = pkgs.fetchFromGitHub {
      owner = "VirtCode";
      repo = "hypr-dynamic-cursors";
      rev = "81f4b964f997a3174596ef22c7a1dee8a5f616c7";
      hash = "sha256-3SDwq2i2QW9nu7HBCPuDtLmrwLt2kajzImBsawKRZ+s=";
    };
  }
)
