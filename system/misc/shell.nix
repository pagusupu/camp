{
  lib,
  config,
  pkgs,
  ...
}: {
  options.cute.misc.shell = {
    enable = lib.mkEnableOption "";
    prompt = lib.mkOption {type = lib.types.lines;};
  };
  config = lib.mkIf config.cute.misc.shell.enable {
    programs.zsh = {
      enable = true;
      autosuggestions.enable = true;
      syntaxHighlighting.enable = true;
      enableGlobalCompInit = false;
      histSize = 10000;
      histFile = "$HOME/.cache/zsh_history";
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
        ssh-server = "ssh pagu@192.168.178.182";
      };
      promptInit = "PROMPT=${config.cute.misc.shell.prompt}";
    };
    environment = {
      shells = [pkgs.zsh];
      binsh = lib.getExe pkgs.dash;
      sessionVariables.FLAKE = "/home/pagu/flake/";
      systemPackages = with pkgs; [
        bat
        eza
        rm-improved
      ];
    };
  };
}
