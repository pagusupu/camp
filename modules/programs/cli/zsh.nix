{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types mkIf getExe;
in {
  options.cute.programs.cli.zsh = {
    enable = mkEnableOption "";
    prompt = mkOption {
      type = types.lines;
      default = "'%F{blue}% %~ >%f '";
    };
  };
  config = let
    inherit (config.cute.programs.cli.zsh) enable prompt;
  in
    mkIf enable {
      programs.zsh = {
        enable = true;
        promptInit = "PROMPT=${prompt}";
        autosuggestions.enable = true;
        syntaxHighlighting.enable = true;
        enableGlobalCompInit = false;
        histSize = 10000;
        histFile = "$HOME/.cache/zsh_history";
        shellInit = ''
          # disable weird underline
          (( ''${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
          ZSH_HIGHLIGHT_STYLES[path]=none
          ZSH_HIGHLIGHT_STYLES[path_prefix]=none
          bindkey "^[[1;5C" forward-word
          bindkey "^[[1;5D" backward-word
          zsh-newuser-install() { :; }
          eval "$(zoxide init zsh)"
          nr() {
            nix run nixpkgs#$1 -- "''${@:2}"
          }
          ns() {
            nix shell nixpkgs#''${^@}
          }
        '';
        shellAliases = {
          cat = "bat --theme='base16'";
          grep = "grep --color=auto";
          ls = "eza --group-directories-first";
          rm = "rip";
          cd = "z";
          update = "sudo nix flake update ~/flake";
          ssh-server = "ssh pagu@192.168.178.182";
        };
      };
      environment = {
        shells = [pkgs.zsh];
        binsh = getExe pkgs.dash;
      };
      users.users.pagu.shell = pkgs.zsh;
    };
}
