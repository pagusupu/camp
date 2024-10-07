{
  config,
  lib,
  cutelib,
  inputs,
  pkgs,
  ...
}: {
  options.cute.desktop.idle = cutelib.mkEnable;
  config = lib.mkIf config.cute.desktop.idle {
    home-manager.users.pagu = {
      imports = [inputs.idle-inhibit.homeModules.default];
      services = {
        hypridle = {
          enable = true;
          settings = {
            general = {
              lock_cmd = "gtklock";
              before_sleep_cmd = "gtklock";
            };
            listener = [
              {
                timeout = 300;
                on-timeout = "gtklock";
              }
            ];
          };
        };
        wayland-pipewire-idle-inhibit = {
          enable = true;
          package = pkgs.wayland-pipewire-idle-inhibit;
          settings = {
            media_minimum_duration = 180;
            node_blacklist = [{name = "feishin";}];
          };
        };
      };
      home.packages = [pkgs.gtklock];
    };
    security.pam.services.gtklock = {};
  };
}
