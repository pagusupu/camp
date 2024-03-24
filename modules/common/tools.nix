{
  lib,
  config,
  pkgs,
  ...
}: {
  options.cute.common = {
    git = lib.mkEnableOption "";
    ssh = lib.mkEnableOption "";
    tools = lib.mkEnableOption "";
    yazi = lib.mkEnableOption "";
  };
  config = let
    inherit (config.cute.common) git ssh tools yazi;
  in {
    programs = {
      git = lib.mkIf git {
        enable = true;
        config = {
          init.defaultBranch = "main";
          user = {
            name = "pagu";
            email = "me@pagu.cafe";
          };
        };
      };
      yazi = lib.mkIf yazi {
        enable = true;
        settings.yazi.manager = {
          sort_by = "natural";
          sort_dir_first = true;
        };
      };
    };
    services.openssh = lib.mkIf ssh {
      enable = true;
      settings = {
        PermitRootLogin = "no";
        PasswordAuthentication = false;
      };
    };
    environment = lib.mkIf tools {
      systemPackages = with pkgs; [
        bat
        btop
        dust
        eza
        nh
        radeontop
        rm-improved
        tealdeer
        speedtest-cli
        unzip
        wget
        zoxide
      ];
      sessionVariables.FLAKE = lib.mkIf tools "/home/pagu/flake/"; # nh
    };
  };
}
