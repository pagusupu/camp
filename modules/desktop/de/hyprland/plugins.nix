{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}:
lib.mkIf (config.cute.desktop.de == "hyprland") {
  assertions = cutelib.assertHm "hyprland-plugins";
  home-manager.users.pagu = {
    wayland.windowManager.hyprland = {
      plugins = with pkgs.hyprlandPlugins; [
        (hypr-dynamic-cursors.overrideAttrs (oldAttrs: {
          src = oldAttrs.src.override {
            rev = "81f4b964f997a3174596ef22c7a1dee8a5f616c7";
            hash = "sha256-3SDwq2i2QW9nu7HBCPuDtLmrwLt2kajzImBsawKRZ+s=";
          };
        }))
        hyprspace
      ];
      settings.plugin = {
        dynamic-cursors = {
          shake = {
            base = 1;
            speed = 1;
            timeout = 300;
          };
          stretch = {
            limit = 6000;
            function = "linear";
          };
          mode = "stretch";
        };
        overview = with config.colours; {
          panelColor = "rgb(${overlay})";
          panelBorderColor = "rgb(${iris})";
          workspaceActiveBorder = "rgb(${iris})";
          workspaceInactiveBorder = "rgb(${subtle})";
        };
      };
    };
  };
}
