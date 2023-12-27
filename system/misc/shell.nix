{
  lib,
  config,
  pkgs,
  ...
}: {
  options.cute.misc.shell = {
    enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.cute.misc.shell.enable {
    environment = {
      shells = [pkgs.zsh];
      binsh = lib.getExe pkgs.dash;
    };
    programs.zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      enableGlobalCompInit = false;
      histSize = 10000;
      histFile = "$HOME/.cache/zsh_history";
      promptInit = "PROMPT='%F{green}% %~ >%f '";
      shellInit = ''
        PROMPT="'%F{green}% %~ >%f '"
        bindkey "^[[1;5C" forward-word
        bindkey "^[[1;5D" backward-word
        bindkey '^H' backward-kill-word
        bindkey '5~' kill-word
        # disable weird underline
        (( ''${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
        ZSH_HIGHLIGHT_STYLES[path]=none
        ZSH_HIGHLIGHT_STYLES[path_prefix]=none
        zsh-newuser-install() { :; }
        # nix run alias
        runix() {
          nix run nixpkgs#$1 -- "''${@:2}"
        }
      '';
      shellAliases = {
        cat = "bat";
        ls = "eza";
        rm = "rip"; 
        switch = "nh os switch";
        update = "sudo nix flake update ~/flake && switch";
      };
    };
  };
}
