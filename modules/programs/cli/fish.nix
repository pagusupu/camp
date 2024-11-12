{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}: {
  options.cute.programs.cli.fish = cutelib.mkEnable;
  config = lib.mkIf config.cute.programs.cli.fish {
    assertions = cutelib.assertHm "fish";
    home-manager.users.pagu = {
      programs = {
        fish = {
          enable = true;
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
          shellInit = ''
            function nr
              nix run nixpkgs#$argv[1] -- $argv[2]
            end

            function ns
              nix shell nixpkgs#$argv
            end

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
          extraOptions = ["--group-directories-first"];
        };
        thefuck = {
          enable = true;
          enableInstantMode = true;
        };
        yazi = {
          enable = true;
          settings.manager = {
            sort_by = "natural";
            sort_dir_first = true;
          };
        };
        zoxide.enable = true;
      };
    };
    environment = {
      binsh = lib.getExe pkgs.dash;
      shells = [pkgs.fish];
    };
    programs.fish.enable = true;
    users.users.pagu.shell = pkgs.fish;
  };
}
