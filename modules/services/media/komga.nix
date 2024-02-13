{
  config,
  lib,
  ...
}: {
  options.cute.services.media.komga = lib.mkEnableOption "";
  config = let
    domain = "komga.${config.cute.services.web.domain}";
  in
    lib.mkIf config.cute.services.media.komga {
      services = {
        komga = {
          enable = true;
          openFirewall = true;
          port = 8097;
        };
        nginx.virtualHosts."${domain}" = {
          forceSSL = true;
          enableACME = true;
          locations."/".proxyPass = "http://127.0.0.1:8097";
        };
      };
    };
}
