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
        hypr-dynamic-cursors
        hyprspace
      ];
      settings.plugin = {
        dynamic-cursors = {
          stretch = {
            limit = 6000;
            function = "linear";
          };
          mode = "stretch";
          shake.enabled = false;
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
