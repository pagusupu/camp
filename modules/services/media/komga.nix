{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.services.media.komga = cutelib.mkEnable;
  config = lib.mkIf config.cute.services.media.komga {
    assertions = cutelib.assertNginx "komga";
    services = {
      komga = {
        enable = true;
        port = 8097;
        openFirewall = true;
      };
      nginx.virtualHosts."kmga.pagu.cafe" = {
        enableACME = true;
        forceSSL = true;
        locations."/".proxyPass = "http://localhost:8097";
      };
    };
  };
}
