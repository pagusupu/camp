{
  config,
  lib,
  ...
}: {
  specialisation = let
    inherit (config.cute.home) base16 gtk;
    inherit (config.cute.common) nixvim;
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
      scheme = lib.mkIf base16 rose-pine/moon.yaml;
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
      scheme = lib.mkIf base16 rose-pine/dawn.yaml;
      programs.nixvim.colorschemes.rose-pine.style = lib.mkIf nixvim "dawn";
    };
  };
}
