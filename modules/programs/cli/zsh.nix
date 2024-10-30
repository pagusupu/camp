{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}: {
  options.cute.programs.cli.zsh = cutelib.mkEnable;
  config = lib.mkIf config.cute.programs.cli.zsh {
    home-manager.users.pagu = {
      programs = {
        zsh = {
          enable = true;
          autocd = true;
          autosuggestion.enable = true;
          syntaxHighlighting.enable = true;
          shellAliases = lib.mkMerge [
            {
              cat = "bat";
              cd = "z";
              grep = "grep --color=auto";
              ls = "eza";
              yazi = "yy";
            }
            {
              ga = "git add -A";
              gc = "git commit -m";
              gp = "git push -u";
              gpo = "git push -u origin main";
              gs = "git status -s";
              gsv = "git status -v";
            }
          ];
          initExtra = ''
            nr() {
              nix run nixpkgs#$1 -- "''${@:2}"
            }
            ns() {
               nix shell nixpkgs#''${^@}
            }
            bindkey "^[[1;5C" forward-word
            bindkey "^[[1;5D" backward-word
            zsh-newuser-install() { :; }
            # disable weird underline
            (( ''${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
            ZSH_HIGHLIGHT_STYLES[path]=none
            ZSH_HIGHLIGHT_STYLES[path_prefix]=none
          '';
          history = {
            expireDuplicatesFirst = true;
            ignoreAllDups = true;
            path = ".config/zsh/zsh_history";
          };
          dotDir = ".config/zsh";
        };
        bat = {
          enable = true;
          config.theme = "base16";
        };
        eza = {
          enable = true;
          git = true;
          icons = "auto";
          extraOptions = ["--group-directories-first"];
        };
        yazi = {
          enable = true;
          settings.manager = {
            sort_by = "natural";
            sort_dir_first = true;
          };
          enableZshIntegration = true;
        };
        fzf.enable = true;
        zoxide.enable = true;
      };
    };
    environment = {
      binsh = lib.getExe pkgs.dash;
      shells = [pkgs.zsh];
    };
    programs.zsh.enable = true;
    users.users.pagu.shell = pkgs.zsh;
  };
}
