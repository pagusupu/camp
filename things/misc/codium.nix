{
  userSettings = {
      "terminal.external.linuxExec": "alacritty",
      "alejandra.program": "alejandra",
      "[nix]": {
        "editor.defaultFormatter": "kamadorueda.alejandra",
        "editor.formatOnPaste": true,
        "editor.formatOnSave": true,
        "editor.formatOnType": true
      },
      "editor.fontFamily": "'firacode', 'monospace', monospace",
      "git.enableSmartCommit": true,
      "git.confirmSync": false,
      "window.menuBarVisibility": "toggle"
    };
  extentions = with pkgs.vscode-extensions; [
    kamadorueda.alejandra
    oderwat.indent-rainbow
    vscode-icons-team.vscode-icons
  ];
}
