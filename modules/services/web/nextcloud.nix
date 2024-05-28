{
  config,
  lib,
  _lib,
  pkgs,
  ...
}: {
  options.cute.services.web.nextcloud = lib.mkEnableOption "";
  config = let
    inherit (config.networking) domain;
  in
    lib.mkIf config.cute.services.web.nextcloud {
      assertions = _lib.assertNginx;
      age.secrets = {
        nextcloud = {
          file = ../../../misc/secrets/nextcloud.age;
          owner = "nextcloud";
        };
      };
      services = {
        nextcloud = {
          enable = true;
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
            trusted_proxies = ["https://next.${domain}"];
            trusted_domains = ["https://next.${domain}"];
          };
          appstoreEnable = false;
          autoUpdateApps.enable = true;
          extraAppsEnable = true;
          extraApps = {
            inherit
              (config.services.nextcloud.package.packages.apps)
              calendar
              contacts
              ;
          };
          hostName = "next.${domain}";
          https = true;
          nginx.recommendedHttpHeaders = true;
        };
        nginx.virtualHosts."next.${domain}" = {
          forceSSL = true;
          enableACME = true;
          http2 = true;
        };
      };
    };
}
