{
  config,
  lib,
  cutelib,
  inputs,
  pkgs,
  ...
}:
lib.mkIf (config.cute.desktop.de == "hyprland")
(lib.mkMerge [
  { assertions = cutelib.assertHm "hyprland-lock"; }
  {
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
          settings = {
            media_minimum_duration = 180;
            node_blacklist = [ { name = "[Ff]eishin"; } ];
          };
          package = pkgs.wayland-pipewire-idle-inhibit;
        };
      };
      imports = [ inputs.idle-inhibit.homeModules.default ];
      home.packages = [ pkgs.gtklock ];
      wayland.windowManager.hyprland.settings.exec-once = [ "gtklock -d" ];
    };
    security.pam.services.gtklock = {};
  }
  {
    services.greetd = {
      enable = true;
      settings = rec {
        initial_session = {
          command = "${lib.getExe pkgs.hyprland}";
          user = "pagu";
        };
        default_session = initial_session;
      };
    };
  }
])
