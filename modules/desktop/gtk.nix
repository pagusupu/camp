{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}: {
  options.cute.desktop = {
    theme = lib.mkOption {
      default = "light";
      type = lib.types.enum ["dark" "light"];
    };
    gtk = cutelib.mkEnable;
    wallpaper-colour = lib.mkOption {type = lib.types.str;};
  };
  config = lib.mkIf config.cute.desktop.gtk (let
    inherit (lib) mkDefault;
  in
    lib.mkMerge [
      {
        assertions = cutelib.assertHm "gtk";
        home-manager.users.pagu = {
          gtk = {
            enable = true;
            theme = {
              package = pkgs.rose-pine-gtk-theme;
              name = mkDefault "rose-pine-dawn";
            };
            iconTheme = {
              package = pkgs.rose-pine-icon-theme;
              name = mkDefault "rose-pine-dawn";
            };
          };
          qt = {
            enable = true;
            platformTheme.name = "gtk";
            style.name = "gtk2";
          };
          home.pointerCursor = {
            package = pkgs.rose-pine-cursor;
            name = mkDefault "BreezeX-RosePineDawn-Linux";
            size = 24;
            gtk.enable = true;
            x11.enable = true;
          };
        };
        specialisation.dark.configuration = {
          home-manager.users.pagu = {
            gtk = {
              theme.name = "rose-pine-moon";
              iconTheme.name = "rose-pine-moon";
            };
            home.pointerCursor.name = "BreezeX-RosePine-Linux";
          };
        };
        programs.dconf.enable = true;
      }
      {
        specialisation.dark.configuration = {
          cute.desktop = {
            theme = "dark";
            wallpaper-colour = "131021";
          };
        };
        cute.desktop.wallpaper-colour = mkDefault "F4EAEB";
      }
    ]);
}
