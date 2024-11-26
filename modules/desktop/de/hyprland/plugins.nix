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
      plugins = with pkgs; [
        hypr-dynamic-cursors
        hyprlandPlugins.hyprspace
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
