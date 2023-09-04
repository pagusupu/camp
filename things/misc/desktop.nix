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
      # changed
      mpv = {
        name = "mpv";
        exec = "mpv --player-operation-mode=pseudo-gui -- %U";
        terminal = false;
      };
      honkers-railway-launcher = {
        name = "Honkers";
        exec = "honkers-railway-launcher";
        terminal = false;
      };
    };
  };
}
