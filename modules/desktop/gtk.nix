{
  pkgs,
  config,
  lib,
  ...
}: {
  options.cute.desktop.gtk = lib.mkEnableOption "";
  config = lib.mkIf config.cute.desktop.gtk {
    home-manager.users.pagu = {
      gtk = {
        enable = true;
        theme = {
          package = pkgs.rose-pine-gtk-theme;
          name = "rose-pine-moon";
        };
        iconTheme = {
          package = pkgs.rose-pine-icon-theme;
          name = "rose-pine-moon";
        };
      };
      qt = {
        enable = true;
        platformTheme = "gtk";
      };
      home = {
        packages = [pkgs.dconf];
        pointerCursor = {
          package = pkgs.rose-pine-cursor;
          name = "BreezeX-RosePineDawn-Linux";
          size = 24;
          gtk.enable = true;
          x11.enable = true;
        };
      };
    };
  };
}
