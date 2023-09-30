{
  xdg = {
    desktopEntries = {
      # removed
      ranger = {
        noDisplay = true;
        name = "ranger";
      };
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
      # changed
      mpv = {
        name = "mpv";
        exec = "mpv --player-operation-mode=pseudo-gui -- %U";
        terminal = false;
      };
    };
  };
}
