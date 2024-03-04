{
  config,
  lib,
  pkgs,
  ...
}: {
  options.cute.desktop.misc.xdg = lib.mkEnableOption "";
  config = lib.mkIf config.cute.desktop.misc.xdg {
    home-manager.users.pagu = {
      xdg = {
        enable = true;
        userDirs = {
          enable = true;
          createDirectories = true;
          documents = "\$HOME/.misc/documents";
          download = "\$HOME/downloads";
          pictures = "\$HOME/pictures";
          desktop = "\$HOME/.misc/desktop";
          music = "\$HOME/.misc/music";
          publicShare = "\$HOME/.misc/public";
          templates = "\$HOME/.misc/templates";
          videos = "\$HOME/pictures/videos";
        };
        desktopEntries = {
          #removed
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
