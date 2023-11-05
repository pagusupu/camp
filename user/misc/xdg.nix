{
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
      picom = {
	noDisplay = true;
	name = "picom";
      };
      # changed
      discord = {
        name = "Discord";
        exec = "discord";
        terminal = false;
      };
      firefox = {
        name = "Firefox";
        exec = "firefox";
        terminal = false;
      };
      mpv = {
        name = "mpv";
        exec = "mpv --player-operation-mode=pseudo-gui -- %U";
        terminal = false;
      };
    };
  };
}
