{
  config,
  lib,
  _lib,
  ...
}: {
  options.cute.desktop.hypr.idle = _lib.mkEnable;
  config = lib.mkIf config.cute.desktop.hypr.idle {
    assertions = _lib.assertHm "hypridle";
    home-manager.users.pagu = {
      services.hypridle = {
        enable = true;
        settings = {
          general = {
            lock_cmd = "hyprlock";
            before_sleep_cmd = "hyprlock";
          };
          listener = [
            {
              timeout = 300;
              on-timeout = "hyprlock";
            }
          ];
        };
      };
    };
  };
}
