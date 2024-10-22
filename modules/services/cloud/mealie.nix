{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.services.cloud.mealie = cutelib.mkEnable;
  config = lib.mkIf config.cute.services.cloud.mealie {
    assertions = cutelib.assertNginx "mealie";
    services = {
      mealie = {
        enable = true;
        port = 9000;
        settings = {
          BASE_URL = "meal.pagu.cafe";
          TZ = "NZ";
        };
      };
      nginx.virtualHosts."meal.pagu.cafe" = {
        enableACME = true;
        forceSSL = true;
        locations."/".proxyPass = "http://localhost:9000";
      };
    };
    fileSystems."/var/lib/private/mealie" = {
      device = "/storage/services/mealie";
      options = ["bind"];
    };
  };
}
