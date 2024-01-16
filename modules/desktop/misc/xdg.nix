{
  config,
  lib,
  pkgs,
  ...
}: {
  options.cute.desktop.misc.xdg.enable = lib.mkEnableOption "";
  config = lib.mkIf config.cute.desktop.misc.xdg.enable {
    home-manager.users.pagu = {
      xdg = {
        enable = true;
        userDirs = {
          enable = true;
          createDirectories = true;
          documents = "\$HOME/documents";
          download = "\$HOME/downloads";
          pictures = "\$HOME/pictures";
          desktop = "\$HOME/.misc/desktop";
          music = "\$HOME/.misc/music";
          publicShare = "\$HOME/.misc/public";
          templates = "\$HOME/.misc/templates";
          videos = "\$HOME/.misc/videos";
        };
        desktopEntries = {
          # removed
          Alacritty = {
            noDisplay = true;
            name = "alacritty";
          };
          htop = {
            noDisplay = true;
            name = "htop";
          };
          nixos-manual = {
            noDisplay = true;
            name = "NixOS Manual";
          };
          nvim = {
            noDisplay = true;
            name = "Neovim Wrapper";
          };
          thunar-settings = {
            noDisplay = true;
            name = "File Manager Settings";
          };
          thunar-bulk-rename = {
            noDisplay = true;
            name = "Bulk Rename";
          };
          # changed
          firefox = {
            name = "Firefox";
            exec = "firefox";
            terminal = false;
          };
          steam = {
            name = "Steam";
            exec = "steam";
            terminal = false;
          };
          mpv = {
            name = "mpv";
            exec = "mpv --player-operation-mode=pseudo-gui -- %U";
            terminal = false;
          };
          thunar = {
            name = "Thunar";
            exec = "thunar";
            terminal = false;
          };
        };
      };
      home.packages = with pkgs; [
        xdg-user-dirs
        xdg-utils
      ];
    };
  };
}
