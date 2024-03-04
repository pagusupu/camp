{
  pkgs,
  config,
  lib,
  ...
}: {
  options.cute.desktop.misc.gtk = lib.mkEnableOption "";
  config = lib.mkIf config.cute.desktop.misc.gtk {
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
      };
      qt = {
        enable = true;
        platformTheme = "gtk";
      };
      home = {
        packages = [pkgs.dconf];
        pointerCursor = {
          package = pkgs.callPackage ../../../pkgs/rose-pine-cursor.nix {};
          name = "BreezeX-RosePineDawn";
          size = 24;
          gtk.enable = true;
          x11.enable = true;
        };
      };
    };
  };
}
