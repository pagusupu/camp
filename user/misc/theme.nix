{pkgs, ...}: {
  gtk = {
    enable = true;
    theme = {
      package = pkgs.rose-pine-gtk-theme;
      name = "rose-pine";
    };
    gtk3.extraConfig = {
      gtk-application-prefer-light-theme = 1;
    };
    gtk3.extraCss = ''
      * { border-radius: 0px; }
    '';
    gtk4.extraConfig = {
      gtk-application-prefer-light-theme = 1;
    };
    gtk4.extraCss = ''
      * { border-radius: 0px; }
    '';
    iconTheme = {
      package = pkgs.rose-pine-icon-theme;
      name = "rose-pine";
    };
  };
  qt = {
    enable = true;
    platformTheme = "gtk";
  };
  home = {
    packages = [pkgs.dconf];
    pointerCursor = {
      package = pkgs.numix-cursor-theme;
      name = "Numix-Cursor";
      size = 32;
      gtk.enable = true;
      x11.enable = true;
    };
  };
}
