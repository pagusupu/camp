{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf getExe;
in {
  options.cute.programs.cli.zsh = mkEnableOption "";
  config = mkIf config.cute.programs.cli.zsh {
    programs.zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        cat = "bat --theme='base16'";
        cd = "z";
        grep = "grep --color=auto";
        ls = "eza --group-directories-first";
        rm = "rip";
        sshaoi = "ssh pagu@192.168.178.182";
      };
      shellInit = ''
        zsh-newuser-install() { :; }
        eval "$(zoxide init zsh)"
        nr() {
          nix run nixpkgs#$1 -- "''${@:2}"
        }
        ns() {
           nom shell nixpkgs#''${^@}
        }
        # disable weird underline
        (( ''${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
        ZSH_HIGHLIGHT_STYLES[path]=none
        ZSH_HIGHLIGHT_STYLES[path_prefix]=none
        bindkey "^[[1;5C" forward-word
        bindkey "^[[1;5D" backward-word
      '';
      histFile = "$HOME/.cache/zsh_history";
      histSize = 10000;
      promptInit = "PROMPT='%F{blue}% %~ >%f '";
    };
    environment = {
      shells = [pkgs.zsh];
      binsh = getExe pkgs.dash;
    };
    users.users.pagu.shell = pkgs.zsh;
  };
}
