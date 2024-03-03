{
  lib,
  config,
  pkgs,
  ...
}: {
  options.cute.common = {
    git = lib.mkEnableOption "";
    tools = lib.mkEnableOption "";
  };
  config = let
    inherit (config.cute.common) git tools;
  in {
    programs.git = lib.mkIf git {
      enable = true;
      config = {
        init.defaultBranch = "main";
        user = {
          name = "pagu";
          email = "me@pagu.cafe";
        };
      };
    };
    environment = lib.mkIf tools {
      systemPackages = with pkgs; [
        bat
        btop
        dust
        eza
        fzf
        nh
        radeontop
        rm-improved
        tldr
        wget
        yazi
        zoxide
      ];
    };
  };
}
