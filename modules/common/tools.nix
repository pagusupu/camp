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
  };
  config = let
    inherit (config.cute.common) git ssh tools;
  in {
    programs = {
      git = lib.mkIf git {
        enable = true;
        config = {
          init.defaultBranch = "main";
          user = {
            name = "pagu";
            email = "me@pagu.cafe";
            signingKey = "/home/pagu/.ssh/id_ed25519.pub";
          };
          gpg.format = "ssh";
          commit.gpgsign = true;
        };
      };
      yazi = lib.mkIf tools {
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
      systemPackages = builtins.attrValues {
        inherit
          (pkgs)
          bat
          btop
          dust
          eza
          fzf
          nh
          ouch
          radeontop
          rm-improved
          tealdeer
          speedtest-cli
          wget
          zoxide
          ;
        localsend-rs = pkgs.callPackage ../../pkgs/localsend-rs.nix {};
      };
      sessionVariables.FLAKE = lib.mkIf tools "/home/pagu/flake/"; # nh
    };
    # localsend
    networking.firewall = lib.mkIf tools {
      allowedTCPPorts = [53317];
      allowedUDPPorts = [53317];
    };
  };
}
