{
  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      documents = "\$HOME/Documents";
      downloads = "\$HOME/Downloads";
      pictures = "\$HOME/Pictures";
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
