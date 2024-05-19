{
  config,
  lib,
  pkgs,
  ...
}: {
  options.cute.gnome.theme = lib.mkEnableOption "";
  config = lib.mkIf config.cute.gnome.theme {
    home-manager.users.pagu = {
      dconf = {
        enable = true;
        settings."org/gnome/desktop/interface" = {
          color-scheme = "prefer-dark";
        };
      };
      gtk = {
        enable = true;
        theme = {
          package = pkgs.orchis-theme;
          name = "Orchis-Pink-Dark";
        };
      };
      qt = {
        enable = true;
        platformTheme.name = "gtk";
      };
      home = {
        pointerCursor = {
          package = pkgs.rose-pine-cursor;
          name = "BreezeX-RosePine-Linux";
          size = 24;
          gtk.enable = true;
          x11.enable = true;
        };
        packages = builtins.attrValues {
          inherit
            (pkgs)
            orchis-theme
            ;
        };
      };
    };
  };
}
