{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.services.web.vaultwarden = cutelib.mkWebOpt "wrdn" 8222;
  config = let
    inherit (config.cute.services.web.vaultwarden) enable dns port;
    inherit (config.networking) domain;
  in
    lib.mkIf enable {
      assertions = cutelib.assertNginx "vaultwarden";
      services.vaultwarden = {
        inherit enable;
        config = {
          DOMAIN = "https://${dns}.${domain}";
          ROCKET_PORT = port;
          SIGNUPS_ALLOWED = false;
        };
        backupDir = "/storage/services/vaultwarden";
      };
    };
}
