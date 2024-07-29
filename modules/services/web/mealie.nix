{
  config,
  lib,
  _lib,
  ...
}: {
  options.cute.services.web.mealie = _lib.mkWebOpt "meal" 9000;
  config = let
    inherit (config.cute.services.web.mealie) enable dns port;
  in
    lib.mkIf enable {
      assertions = _lib.assertNginx "mealie";
      services.mealie = {
        inherit enable port;
        settings = {
          BASE_URL = "${dns}.${config.networking.domain}";
          TZ = "NZ";
        };
      };
      fileSystems."/var/lib/private/mealie" = {
        device = "/storage/services/mealie";
        options = ["bind"];
      };
    };
}
