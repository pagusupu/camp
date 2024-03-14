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
    users.users.pagu.openssh.authorizedKeys.keys = lib.mkIf ssh [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKj709k07PEtMHhT9Leb1pVkS2kduiyogmyXqNmLRgfp" # server
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMGwCFQYJB+4nhIqktQwJemynSOEP/sobnV2vESSY3tk" # desktop nixos
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIqJoNQ+5r3whthoNHP3C++gI/KE6iMgrD81K6xDQ//V" # desktop windows
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAqzdZDv69pd3yQEIiq79vRKrDE5PlxINJFhpDvpE/vR" # laptop
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPyA6gv1M1oeN8CnDLR3Z3VdcgK3hbRhHB3Nk6VbWwjK" # phone
    ];
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
        speedtest-cli
        unzip
        wget
        zoxide
      ];
      sessionVariables.FLAKE = lib.mkIf tools "/home/pagu/flake/"; # nh
      variables = lib.mkIf yazi {
        YAZI_CONFIG_HOME = lib.mkForce "/etc/yazi";
      };
    };
  };
}
