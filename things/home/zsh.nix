{
  config,
  lib,
  ...
}: {
  options.cute.programs.zsh = {
    enable = lib.mkEnableOption "";
    prompt = lib.mkOption {
      default = "'%F{green}% %~ > %f'";
      type = lib.types.str;
    };
  };
  config = lib.mkIf config.cute.programs.zsh.enable {
    programs.zsh = {
      enable = true;
      dotDir = ".config/zsh";
      enableCompletion = true;
      enableAutosuggestions = true;
      history = {
        save = 1000;
        size = 1000;
        path = "$HOME/.cache/zsh_history";
      };
      initExtra = ''
        PROMPT=${config.cute.programs.zsh.prompt}
        bindkey "^[[1;5C" forward-word
        bindkey "^[[1;5D" backward-word
        bindkey '^H' backward-kill-word
        bindkey '5~' kill-word
        # disable weird underline
        (( ''${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
        ZSH_HIGHLIGHT_STYLES[path]=none
        ZSH_HIGHLIGHT_STYLES[path_prefix]=none
        runix() {
            nix run nixpkgs#$1 -- "''${@:2}"
        }
      '';
      shellAliases = {
        ls = "ls --color";
        switch = "sudo nixos-rebuild switch --flake ~/Nix/#desktop";
        update = "sudo nix flake update ~/Nix && switch";
      };
    };
  };
}
