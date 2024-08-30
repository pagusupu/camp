{
  config,
  lib,
  _lib,
  pkgs,
  ...
}: {
  options.cute.services.web.nextcloud = _lib.mkWebOpt "next" null;
  config = let
    inherit (config.cute.services.web.nextcloud) enable dns;
    inherit (config.networking) domain;
  in
    lib.mkIf enable {
      assertions = _lib.assertNginx "nextcloud";
      age.secrets.nextcloud = {
        file = ../../../misc/secrets/nextcloud.age;
        owner = "nextcloud";
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
        settings = {
          default_phone_region = "NZ";
          overwriteprotocol = "https";
          trusted_domains = ["https://${dns}.${domain}"];
          trusted_proxies = ["127.0.0.1"];
        };
        appstoreEnable = false;
        autoUpdateApps.enable = true;
        extraAppsEnable = true;
        extraApps = {
          inherit
            (config.services.nextcloud.package.packages.apps)
            bookmarks
            calendar
            contacts
            notes
            tasks
            ;
          news = pkgs.fetchNextcloudApp {
            sha256 = "sha256-nj1yR2COwQ6ZqZ1/8v9csb/dipXMa61e45XQmA5WPwg=";
            url = "https://github.com/nextcloud/news/releases/download/25.0.0-alpha8/news.tar.gz";
            license = "gpl3";
          };
        };
        hostName = "${dns}.${domain}";
        https = true;
        nginx.recommendedHttpHeaders = true;
      };
    };
}
