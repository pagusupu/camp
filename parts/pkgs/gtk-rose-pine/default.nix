{pkgs, ...}:
pkgs.rose-pine-gtk-theme.overrideAttrs (_prev: {
  pname = "gtk-rose-pine";
  version = "unstable-2024-10-08";
  src = pkgs.fetchFromGitHub {
    owner = "rose-pine";
    repo = "gtk";
    rev = "d0d7815f0af2facd3157e005cd7c606d4f28d881";
    hash = "sha256-vCWs+TOVURl18EdbJr5QAHfB+JX9lYJ3TPO6IklKeFE=";
  };
})
