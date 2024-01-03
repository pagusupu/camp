{
  pkgs,
  inputs,
  ...
}: {
  gtk = {
    enable = true;
    theme = {
      package = inputs.mountain.packages.${pkgs.system}.gtk;
      name = "mountain";
    };
    gtk3.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk3.extraCss = ''
      * { border-radius: 0px; }
    '';
    gtk4.extraConfig = {
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraCss = ''
      * { border-radius: 0px; }
    '';
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
