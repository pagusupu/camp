{
  config,
  lib,
  ...
}: {
  options.cute.services.frge = lib.mkEnableOption "";
  config = let
    inherit (config.networking) domain;
  in
    lib.mkIf config.cute.services.frge {
      services = {
        forgejo = {
          enable = true;
          settings = {
            other.SHOW_FOOTER_VERSION = false;
            service.DISABLE_REGSTRATION = true;
            session.COOKIE_SECURE = true;
            server = {
              ROOT_URL = "https://frge.${domain}";
              DOMAIN = "frge.${domain}";
              HTTP_PORT = 8333;
              LANDING_PAGE = "/explore/repos";
            };
          };
          stateDir = "/storage/services/forgejo";
        };
        nginx.virtualHosts."frge.${domain}" = {
          forceSSL = true;
          enableACME = true;
          locations."/".proxyPass = "http://127.0.0.1:${toString config.services.forgejo.settings.server.HTTP_PORT}";
        };
      };
    };
}
