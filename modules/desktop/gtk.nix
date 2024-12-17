{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}: {
  options.cute.desktop.gtk = cutelib.mkEnable;
  config = lib.mkIf config.cute.desktop.gtk (let
    inherit (lib) mkMerge mkDefault mkIf;
  in
    mkMerge [
      {
        assertions = cutelib.assertHm "gtk";
        home-manager.users.pagu = {
          gtk = {
            enable = true;
            theme = {
              package = pkgs.rose-pine-gtk-theme.overrideAttrs (
                oldAttrs: {
                  src = oldAttrs.src.override {
                    rev = "d0d7815f0af2facd3157e005cd7c606d4f28d881";
                    sha256 = "vCWs+TOVURl18EdbJr5QAHfB+JX9lYJ3TPO6IklKeFE=";
                  };
                }
              );
              name = mkDefault "rose-pine-dawn";
            };
            iconTheme = {
              package = pkgs.rose-pine-icon-theme;
              name = mkDefault "rose-pine-dawn";
            };
          };
          qt = {
            enable = true;
            platformTheme.name = "gtk2";
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
        programs.dconf.enable = true;
      }
      (mkIf config.cute.dark {
        specialisation.dark.configuration = {
          home-manager.users.pagu = {
            gtk = {
              theme.name = "rose-pine";
              iconTheme.name = "rose-pine";
            };
            home.pointerCursor.name = "BreezeX-RosePine-Linux";
          };
        };
      })
    ]);
}
