{
  config,
  lib,
  cutelib,
  inputs,
  pkgs,
  ...
}:
lib.mkIf (config.cute.desktop.de == "hyprland") {
  assertions = cutelib.assertHm "idle";
  home-manager.users.pagu = {
    services = {
      hypridle = {
        enable = true;
        settings = {
          listener = [
            {
              timeout = 300;
              on-timeout = "gtklock";
            }
          ];
          general.lock_cmd = "gtklock";
        };
      };
      wayland-pipewire-idle-inhibit = {
        enable = true;
        package = pkgs.wayland-pipewire-idle-inhibit;
        settings.media_minimum_duration = 180;
      };
    };
    imports = [inputs.idle-inhibit.homeModules.default];
    home.packages = [pkgs.gtklock];
    wayland.windowManager.hyprland.settings.exec-once = ["gtklock -d"];
  };
  security.pam.services.gtklock = {};
}
