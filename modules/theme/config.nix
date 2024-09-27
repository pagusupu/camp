{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}: let
  inherit (lib) mkOption types mkMerge mkIf mkDefault;
  inherit (config.cute.theme) gtk;
in {
  options.cute.theme = {
    type = mkOption {
      default = "light";
      type = types.enum ["dark" "light"];
    };
    gtk = cutelib.mkEnable;
  };
  config = mkMerge [
    (mkIf gtk {
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
          platformTheme = {
            name = mkDefault "adwaita";
            package = pkgs.adwaita-qt;
          };
          style = {
            name = mkDefault "adwaita";
            package = pkgs.adwaita-qt;
          };
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
          qt = {
            platformTheme.name = "adwaita-dark";
            style.name = "adwaita-dark";
          };
          home.pointerCursor.name = "BreezeX-RosePine-Linux";
        };
      };
      programs.dconf.enable = true;
    })
    {
      specialisation.dark.configuration = {
        boot.loader.grub.configurationName = "dark";
        cute.theme.type = "dark";
        environment.etc."specialisation".text = "dark";
      };
    }
  ];
}
