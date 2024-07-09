{
  lib,
  config,
  pkgs,
  ...
}: {
  options.cute.programs.cli.zsh = lib.mkEnableOption "";
  config = lib.mkIf config.cute.programs.cli.zsh {
    programs.zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      shellAliases = {
        cat = "bat --theme='base16'";
        cd = "z";
        ga = "git add -A";
        gc = "git commit -m";
        gp = "git push -u";
        gpo = "git push -u origin main";
        gs = "git status -s";
        gsv = "git status -v";
        grep = "grep --color=auto";
        ls = "eza --group-directories-first";
        rm = "rip";
        sshaoi = "ssh pagu@192.168.178.182";
      };
      shellInit =
        # sh
        ''
          zsh-newuser-install() { :; }
          eval "$(zoxide init zsh)"
          nr() {
            nix run nixpkgs#$1 -- "''${@:2}"
          }
          ns() {
             nom shell nixpkgs#''${^@}
          }
          bindkey "^[[1;5C" forward-word
          bindkey "^[[1;5D" backward-word
          # disable weird underline
          (( ''${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
          ZSH_HIGHLIGHT_STYLES[path]=none
          ZSH_HIGHLIGHT_STYLES[path_prefix]=none
        '';
      histFile = "$HOME/.cache/zsh_history";
      histSize = 10000;
      promptInit = "PROMPT='%F{blue}% %~ >%f '";
    };
    environment = {
      binsh = lib.getExe pkgs.dash;
      shells = [pkgs.zsh];
      systemPackages = with pkgs; [
        bat
        eza
        fzf
        nix-output-monitor
        rm-improved
        zoxide
      ];
    };
    users.users.pagu.shell = pkgs.zsh;
  };
}
