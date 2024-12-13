{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.services.cloud.mealie = cutelib.mkEnable;
  config = lib.mkIf config.cute.services.cloud.mealie {
    assertions = cutelib.assertNginx "mealie";
    services = let
      port = 9000;
    in {
      mealie = {
        enable = true;
        settings = {
          ALLOW_SIGNUP = true;
          BASE_URL = "meal.${config.networking.domain}";
          TZ = "NZ";
        };
        inherit port;
      };
      nginx = cutelib.host "meal" port "" "";
    };
    fileSystems."/var/lib/private/mealie" = {
      device = "/storage/mealie";
      options = [ "bind" ];
    };
  };
}
