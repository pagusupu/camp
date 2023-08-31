{
  config,
  lib,
  ...
}: {
  options.local.programs.zsh = {
    enable = lib.mkEnableOption "";
    prompt = lib.mkOption {
      default = "'%F{red}% %~ > %f'";
      type = lib.types.str;
    };
  };
  config = lib.mkIf config.local.programs.zsh.enable {
    programs.zsh = {
      enable = true;
      dotDir = ".config/zsh";
      enableCompletion = true;
      enableAutosuggestions = true;
     #syntaxHighlighting = true;
      history = {
        save = 1000;
        size = 1000;
        path = "$HOME/.cache/zsh_history";
      };
      initExtra = ''
        PROMPT=${config.local.programs.zsh.prompt}
        bindkey "^[[1;5C" forward-word
        bindkey "^[[1;5D" backward-word
        # ctrl backwards / delete
        bindkey '^H' backward-kill-word
        bindkey '5~' kill-word
        # disable weird underline
        (( ''${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
        ZSH_HIGHLIGHT_STYLES[path]=none
        ZSH_HIGHLIGHT_STYLES[path_prefix]=none
      '';
      #profileExtra = ''
       # if [[ -z "$DISPLAY" ]] && [[ $(tty) = /dev/tty1 ]]; then
        #  Hyprland
       # fi
    #  '';
      shellAliases = {
        ls = "ls --color";
        switch = "sudo nixos-rebuild switch --flake ~/Nix/# && rm ~/.cache/tofi-drun";
      };
    };
  };
}
