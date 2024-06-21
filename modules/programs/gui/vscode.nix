{
  config,
  lib,
  pkgs,
  ...
}: {
  options.cute.programs.gui.vscode = lib.mkEnableOption "";
  config = lib.mkIf config.cute.programs.gui.vscode {
    home-manager.users.pagu = {
      programs.vscode = {
        enable = true;
        package = pkgs.vscodium;
        extensions = with pkgs.vscode-extensions; [
          jnoortheen.nix-ide
          kamadorueda.alejandra
          vscode-icons-team.vscode-icons
        ];
        userSettings = {
          "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'monospace', monospace";
          "nix.enableLanguageServer" = true;
          "nix.formatterPath" = "alejandra";
          "nix.serverPath" = "nil";
          "nix.serverSettings"."nil"."formatting" = {"command" = ["alejandra --quiet"];};
          "vsicons.dontShowNewVersionMessage" = true;
          "workbench.iconTheme" = "vscode-icons";
        };
      };
      home.packages = with pkgs; [
        alejandra
        nil
      ];
    };
  };
}
