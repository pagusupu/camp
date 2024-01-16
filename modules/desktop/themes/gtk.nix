{
  pkgs,
  config,
  lib,
  ...
}: {
  options.cute.desktop.themes.gtk.theme = lib.mkEnableOption "";
  config = lib.mkIf config.cute.desktop.themes.gtk.theme {
    home-manager.users.pagu = {
      gtk = {
        enable = true;
        theme = {
          package = pkgs.rose-pine-gtk-theme;
          name = "rose-pine";
        };
        iconTheme = {
          package = pkgs.rose-pine-icon-theme;
          name = "rose-pine";
        };
        gtk3.extraCss = ''
          * { border-radius: 0px; }
        '';
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
    };
  };
}
