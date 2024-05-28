{
  config,
  lib,
  _lib,
  ...
}: {
  options.cute.services.web.vaultwarden = lib.mkEnableOption "";
  config = let
    inherit (config.networking) domain;
  in
    lib.mkIf config.cute.services.web.vaultwarden {
      assertions = _lib.assertNginx;
      services = {
        vaultwarden = {
          enable = true;
          config = {
            DOMAIN = "https://wrdn.${domain}";
            SIGNUPS_ALLOWED = true;
            ROCKET_ADDRESS = "127.0.0.1";
            ROCKET_PORT = 8222;
          };
          backupDir = "/storage/services/vaultwarden";
        };
        nginx.virtualHosts."wrdn.${domain}" = {
          forceSSL = true;
          enableACME = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:8222";
            extraConfig = "proxy_pass_header Authorization;";
          };
        };
      };
    };
}
