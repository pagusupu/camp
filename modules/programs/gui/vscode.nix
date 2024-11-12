{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}: {
  options.cute.programs.gui.vscode = cutelib.mkEnable;
  config = lib.mkIf config.cute.programs.gui.vscode {
    assertions = cutelib.assertHm "vscode";
    home-manager.users.pagu = {
      programs.vscode = {
        enable = true;
        package = pkgs.vscodium;
        extensions = with pkgs.vscode-extensions; [
          jnoortheen.nix-ide
          mvllow.rose-pine
          rust-lang.rust-analyzer
          vscode-icons-team.vscode-icons
        ];
        userSettings = {
          "editor.cursorBlinking" = "solid";
          "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'monospace', 'monspace'";
          "editor.fontLigatures" = true;
          "editor.formatOnSave" = true;
          "explorer.confirmDelete" = true;
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "${lib.getExe pkgs.nil}";
          "nix.serverSettings.nil" = {
            formatting.command = ["${lib.getExe pkgs.alejandra}"];
            nix.flake.autoArchive = false;
          };
          "vsicons.dontShowNewVersionMessage" = true;
          "workbench.colorTheme" = lib.mkDefault "Rosé Pine Dawn (no italics)";
          "workbench.iconTheme" = "vscode-icons";
        };
        enableExtensionUpdateCheck = false;
        enableUpdateCheck = false;
      };
    };
    specialisation.dark.configuration = lib.mkIf config.cute.dark {
      home-manager.users.pagu = {
        programs.vscode = {
          userSettings."workbench.colorTheme" = "Rosé Pine Moon (no italics)";
        };
      };
    };
  };
}
