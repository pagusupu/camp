{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}: {
  options.cute.programs.cli.shell = cutelib.mkEnable;
  config = lib.mkIf config.cute.programs.cli.shell {
    assertions = cutelib.assertHm "shell";
    home-manager.users.pagu = {
      programs = {
        fish = {
          enable = true;
          functions = {
            nr = "nix run nixpkgs#$argv[1] -- $argv[2]";
            ns = "nix shell nixpkgs#$argv";
          };
          shellAliases = {
            cat = "bat";
            cd = "z";
            grep = "grep --color=auto";
            ls = "eza";

            ga = "git add -A";
            gc = "git commit -m";
            gp = "git push -u";
            gpo = "git push -u origin main";
            gs = "git status -s";
            gsv = "git status -v";
          };
          plugins = [
            {
              name = "autopair";
              inherit (pkgs.fishPlugins.autopair) src;
            }
            {
              name = "pufferfish";
              src = pkgs.fetchFromGitHub {
                owner = "nickeb96";
                repo = "puffer-fish";
                rev = "12d062eae0ad24f4ec20593be845ac30cd4b5923";
                hash = "sha256-2niYj0NLfmVIQguuGTA7RrPIcorJEPkxhH6Dhcy+6Bk=";
              };
            }
          ];
          shellInit = ''
            set fish_color_valid_path cyan
            set -u fish_greeting
          '';
        };
        bat = {
          enable = true;
          config.theme = "base16";
        };
        direnv = {
          enable = true;
          nix-direnv.enable = true;
        };
        eza = {
          enable = true;
          icons = "auto";
          extraOptions = [ "--group-directories-first" ];
        };
        yazi = {
          enable = true;
          settings.manager = {
            show_hidden = true;
            sort_by = "natural";
            sort_dir_first = true;
          };
          plugins = let
            yazi-plugins = pkgs.fetchFromGitHub {
              owner = "yazi-rs";
              repo = "plugins";
              rev = "540f4ea6d475c81cba8dac252932768fbd2cfd86";
              hash = "sha256-IRv75b3SR11WfLqGvQZhmBo1BuR5zsbZxfZIKDVpt9k=";
            };
          in {
            full-border = "${yazi-plugins}/full-border.yazi";
          };
          initLua = ''require("full-border"):setup()'';
        };
        zoxide.enable = true;
      };
    };
    environment = {
      binsh = lib.getExe pkgs.dash;
      shells = [ pkgs.fish ];
      sessionVariables.DIRENV_LOG_FORMAT = "";
    };
    programs.fish.enable = true;
    users.users.pagu.shell = pkgs.fish;
  };
}
