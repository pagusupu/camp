{
  config,
  lib,
  ...
}: {
  options.cute.services.web.frge = lib.mkEnableOption "";
  config = let
    inherit (config.networking) domain;
  in
    lib.mkIf config.cute.services.web.frge {
      services = {
        forgejo = {
          enable = true;
          settings = {
            other.SHOW_FOOTER_VERSION = false;
            repository.DISABLE_STARS = true;
            service.DISABLE_REGSTRATION = true;
            session.COOKIE_SECURE = true;
            server = {
              DOMAIN = "frge.${domain}";
              HTTP_PORT = 8333;
              LANDING_PAGE = "/explore/repos";
              ROOT_URL = "https://frge.${domain}";
            };
            DEFAULT.APP_NAME = "Forgejo";
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
