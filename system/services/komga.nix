{
  config,
  lib,
  ...
}: {
  options.cute.services.komga.enable = lib.mkEnableOption "";
  config = let
    domain = "komga.${config.cute.services.nginx.domain}";
  in
    lib.mkIf config.cute.services.komga.enable {
      services = {
        komga = {
          enable = true;
          openFirewall = true;
          port = 8097;
          # stateDir = "/storage/services/komga/state";
        };
        nginx.virtualHosts."${domain}" = {
          forceSSL = true;
          enableACME = true;
          locations."/".proxyPass = "http://127.0.0.1:8097";
        };
      };
    };
}
