{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.desktop.hypr.idle = cutelib.mkEnable;
  config = lib.mkIf config.cute.desktop.hypr.idle {
    assertions = cutelib.assertHm "hypridle";
    home-manager.users.pagu = {
      services.hypridle = {
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
    };
  };
}
