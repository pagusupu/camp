{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}: {
  options.cute.services.web.nextcloud = cutelib.mkWebOpt "next" 0;
  config = let
    inherit (config.cute.services.web.nextcloud) enable dns;
    inherit (config.networking) domain;
  in
    lib.mkIf enable {
      assertions = cutelib.assertNginx "nextcloud";
      age.secrets.nextcloud = {
        file = ../../../secrets/nextcloud.age;
        owner = "nextcloud";
      };
      services = {
        nextcloud = {
          inherit enable;
          package = pkgs.nextcloud29;
          home = "/storage/services/nextcloud";
          configureRedis = true;
          config = {
            adminuser = "pagu";
            adminpassFile = config.age.secrets.nextcloud.path; # setup only
          };
          phpOptions = {
            "opcache.interned_strings_buffer" = "16";
            "output_buffering" = "off";
          };
          settings = {
            default_phone_region = "NZ";
            overwriteprotocol = "https";
            trusted_domains = ["https://${dns}.${domain}"];
            trusted_proxies = ["127.0.0.1"];
          };
          hostName = "${dns}.${domain}";
          https = true;
        };
        nginx.virtualHosts."${dns}.${domain}" = {
          enableACME = true;
          forceSSL = true;
        };
      };
    };
}
