{
  config,
  lib,
  _lib,
  ...
}: {
  options.cute.services.web.vaultwarden = _lib.mkWebOpt "wrdn" 8222;
  config = let
    inherit (config.cute.services.web.vaultwarden) enable dns port;
    inherit (config.networking) domain;
  in
    lib.mkIf enable {
      assertions = _lib.assertNginx;
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
