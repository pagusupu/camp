{pkgs}:
pkgs.vimUtils.buildVimPlugin {
  pname = "rose-pine-nvim";
  version = "2024-10-23";
  src = pkgs.fetchFromGitHub {
    owner = "rose-pine";
    repo = "neovim";
    rev = "07a887a7bef4aacea8c7caebaf8cbf808cdc7a8e";
    sha256 = "00gyn9s5c76fk1sqyg48aldbq2d8m33xia48vik8grj9wp12kbpx";
  };
  patches = [./notify-fix.patch];
}
