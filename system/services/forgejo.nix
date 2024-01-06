{
  config,
  lib,
  ...
}: {
  options.cute.services.forgejo.enable = lib.mkEnableOption "";
  config = let
    domain = "forge.${config.cute.services.nginx.domain}";
  in
    lib.mkIf config.cute.services.forgejo.enable {
      services = {
        forgejo = {
          enable = true;
          settings = {
            ui.DEFAULT_THEME = "forgejo-dark";
            service.DISABLE_REGSTRATION = true;
            session.COOKIE_SECURE = true;
            server = {
              ROOT_URL = "https://${domain}";
              DOMAIN = "${domain}";
              HTTP_PORT = 8333;
              LANDING_PAGE = "/explore/repos";
            };
          };
          stateDir = "/storage/services/forgejo";
        };
        nginx.virtualHosts."${domain}" = {
          forceSSL = true;
          enableACME = true;
          locations."/".proxyPass = "http://127.0.0.1:${toString config.services.forgejo.settings.server.HTTP_PORT}";
        };
      };
    };
}
