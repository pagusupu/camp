{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.services.web.vaultwarden = cutelib.mkEnable;
  config = lib.mkIf config.cute.services.web.vaultwarden {
    services = let
      port = 8222;
    in {
      vaultwarden = {
        enable = true;
        config = {
          DOMAIN = "https://wrdn.${config.networking.domain}";
          ROCKET_PORT = port;
          SIGNUPS_ALLOWED = false;
        };
        backupDir = "/storage/vaultwarden";
      };
      nginx = cutelib.host "wrdn" port "" "proxy_pass_header Authorization;";
    };
  };
}
