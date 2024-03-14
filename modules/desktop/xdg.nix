{
  config,
  lib,
  pkgs,
  ...
}: {
  options.cute.desktop.xdg = lib.mkEnableOption "";
  config = lib.mkIf config.cute.desktop.xdg {
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
        desktopEntries = let
          no = {noDisplay = true;};
        in {
          Alacritty = no // {name = "alacritty";};
          btop = no // {name = "btop++";};
          nixos-manual = no // {name = "NixOS Manual";};
          nvim = no // {name = "Neovim Wrapper";};
          # changed
          firefox = {
            name = "Firefox";
            exec = "firefox";
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
