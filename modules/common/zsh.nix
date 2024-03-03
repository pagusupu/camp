{
  lib,
  config,
  pkgs,
  ...
}: {
  options.cute.common.zsh = {
    enable = lib.mkEnableOption "";
    prompt = lib.mkOption {type = lib.types.lines;};
  };
  config = lib.mkIf config.cute.common.zsh.enable {
    programs.zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      enableGlobalCompInit = false;
      histSize = 10000;
      histFile = "$HOME/.cache/zsh_history";
      shellInit = ''
        eval "$(zoxide init zsh)"
        bindkey "^[[1;5C" forward-word
        bindkey "^[[1;5D" backward-word
        bindkey '^H' backward-kill-word
        bindkey '5~' kill-word
        # disable weird underline
        (( ''${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
        ZSH_HIGHLIGHT_STYLES[path]=none
        ZSH_HIGHLIGHT_STYLES[path_prefix]=none
        zsh-newuser-install() { :; }
        nr() {
          nix run nixpkgs#$1 -- "''${@:2}"
        }
	ns() {
	  nix shell nixpkgs#''${^@}
	}
      '';
      shellAliases = {
        cat = "bat";
	grep = "grep --color=auto";
        ls = "eza";
        rm = "rip";
	cd = "z";
        update = "sudo nix flake update ~/flake && nh os switch";
        ssh-server = "ssh pagu@192.168.178.182";
      };
      promptInit = "PROMPT=${config.cute.common.zsh.prompt}";
    };
    environment = {
      shells = [pkgs.zsh];
      binsh = lib.getExe pkgs.dash;
      sessionVariables.FLAKE = "/home/pagu/flake/"; 
    };
  };
}
