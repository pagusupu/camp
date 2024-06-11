{
  config,
  lib,
  _lib,
  pkgs,
  ...
}: {
  options.cute.services.web.nextcloud = _lib.mkWebOpt "next" 0;
  config = let
    inherit (config.cute.services.web.nextcloud) enable dns;
    inherit (config.networking) domain;
  in
    lib.mkIf enable {
      assertions = _lib.assertNginx;
      age.secrets = {
        nextcloud = {
          file = ../../../misc/secrets/nextcloud.age;
          owner = "nextcloud";
        };
      };
      services.nextcloud = {
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
        settings = rec {
          default_phone_region = "NZ";
          overwriteprotocol = "https";
          trusted_domains = ["https://${dns}.${domain}"];
          trusted_proxies = trusted_domains;
        };
        appstoreEnable = false;
        autoUpdateApps.enable = true;
        extraAppsEnable = true;
        extraApps = {
          inherit
            (config.services.nextcloud.package.packages.apps)
            calendar
            contacts
            notes
            ;
        };
        hostName = "${dns}.${domain}";
        https = true;
        nginx.recommendedHttpHeaders = true;
      };
    };
}
