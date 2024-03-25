{
  lib,
  config,
  pkgs,
  ...
}: {
  options.cute.common.zsh = {
    enable = lib.mkEnableOption "";
    starship = lib.mkEnableOption "";
  };
  config = let
    inherit (config.cute.common.zsh) enable starship;
  in {
    programs = {
      zsh = lib.mkIf enable {
        enable = true;
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
          update = "sudo nix flake update ~/flake && nh os switch";
          ssh-server = "ssh pagu@192.168.178.182";
        };
      };
      starship = lib.mkIf starship {
        enable = true;
        settings = {
          add_newline = false;
          character = {
            success_symbol = "[](bold green)";
            error_symbol = "[](bold red)";
          };
          directory = {
            home_symbol = " ";
            read_only = " ";
            style = "bold purple";
            truncation_length = 5;
          };
          git_status.deleted = "x";
          hostname.format = "[$hostname]($style) in ";
        };
      };
    };
    environment = {
      shells = [pkgs.zsh];
      binsh = lib.getExe pkgs.dash;
    };
    users.users.pagu.shell = pkgs.zsh;
  };
}
