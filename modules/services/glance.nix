{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.services.glance = cutelib.mkEnable;
  config = lib.mkIf config.cute.services.glance {
    services.glance = {
      enable = true;
      openFirewall = true;
      settings = {
        server = {
          port = 8333;
          host = "0.0.0.0";
        };
      };
    };
  };
}
