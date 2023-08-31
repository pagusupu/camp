{pkgs, ...}: {
  home = {
    pointerCursor = {
      package = pkgs.numix-cursor-theme;
      name = "Numix-Cursor";
      size = 32;
      gtk.enable = true;
      x11.enable = true;
    };
  };
}
