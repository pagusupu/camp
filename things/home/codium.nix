{
  pkgs,
  lib,
  config,
  ...
}: {
  options.cute.programs.codium = {
    enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.cute.programs.codium.enable {
    programs = {
      vscode = {
        enable = true;
        package = pkgs.vscodium;
        mutableExtensionsDir = false;
        extensions = with pkgs.vscode-extensions; [
          #kamadorueda.alejandra
          oderwat.indent-rainbow
          vscode-icons-team.vscode-icons
        ];
        userSettings = {
          "[nix]" = {
            "editor.defaultFormatter" = "kamadorueda.alejandra";
            "editor.formatOnPaste" = true;
            "editor.formatOnSave" = true;
            "editor.formatOnType" = true;
          };
          "alejandra.program" = "alejandra";
          "editor.fontFamily" = "'firacode', 'monospace', monospace";
          "editor.minimap.enabled" = false;
          "explorer.confirmDelete" = false;
          "explorer.confirmDragAndDrop" = false;
          "git.enableSmartCommit" = true;
          "git.confirmSync" = false;
          "terminal.external.linuxExec" = "alacritty";
          "window.menuBarVisibility" = "toggle";
          "workbench.colorTheme" = "Dark Modern";
          "workbench.iconTheme" = "vscode-icons";
          "workbench.startupEditor" = "none";
        };
      };
    };
  };
}
