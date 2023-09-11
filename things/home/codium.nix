{pkgs, ...}: {
  programs = {
    git = {
      enable = true;
      userName = "pagusupu";
      userEmail = "me@pagu.cafe";
    };
    vscode = {
      enable = true;
      package = pkgs.vscodium;
      mutableExtensionsDir = false;
      extensions = with pkgs.vscode-extensions; [
        kamadorueda.alejandra
        oderwat.indent-rainbow
        vscode-icons-team.vscode-icons
      ];
      userSettings = {
        "terminal.external.linuxExec" = "alacritty";
        "alejandra.program" = "alejandra";
        "[nix]" = {
          "editor.defaultFormatter" = "kamadorueda.alejandra";
          "editor.formatOnPaste" = true;
          "editor.formatOnSave" = true;
          "editor.formatOnType" = true;
        };
        "editor.fontFamily" = "'firacode', 'monospace', monospace";
        "git.enableSmartCommit" = true;
        "git.confirmSync" = false;
        "window.menuBarVisibility" = "toggle";
        "workbench.iconTheme" = "vscode-icons";
        "editor.minimap.enabled" = false;
        "workbench.startupEditor" = "none";
        "workbench.colorTheme" = "Dark Modern";
      };
    };
  };
}
