{
  config,
  lib,
  ...
}: {
  specialisation = let
    inherit (config.cute.home) gtk;
  in {
    dark.configuration = {
      home-manager.users.pagu = lib.mkIf gtk {
        gtk = {
          theme.name = "rose-pine-moon";
          iconTheme.name = "rose-pine-moon";
          gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
          gtk4.extraConfig.gtk-application-prefer-dark-theme = 1;
        };
        home.pointerCursor.name = "BreezeX-RosePineDawn-Linux";
      };
      scheme = rose-pine/moon.yaml;
      programs.nixvim.colorschemes.rose-pine.style = "moon";
    };
    light.configuration = {
      home-manager.users.pagu = lib.mkIf gtk {
        gtk = {
          theme.name = "rose-pine-dawn";
          iconTheme.name = "rose-pine-dawn";
        };
        home.pointerCursor.name = "BreezeX-RosePine-Linux";
      };
      scheme = rose-pine/dawn.yaml;
      programs.nixvim.colorschemes.rose-pine.style = "dawn";
    };
  };
}
