{
  config,
  pkgs,
  lib,
  ...
}: {
  options.cute.services.cloud = lib.mkEnableOption "";
  config = let
    domain = "cloud.${config.cute.services.nginx.domain}";
  in
    lib.mkIf config.cute.services.cloud {
      age.secrets.nextcloud = {
        file = ../../secrets/nextcloud.age;
        owner = "nextcloud";
      };
      services = {
        nextcloud = {
          enable = true;
          package = pkgs.nextcloud28;
          hostName = domain;
          home = "/storage/services/nextcloud";
          autoUpdateApps.enable = true;
          configureRedis = true;
          config = {
            overwriteProtocol = "https";
            extraTrustedDomains = ["https://${domain}"];
            trustedProxies = ["https://${domain}"];
            adminuser = "pagu";
            adminpassFile = config.age.secrets.nextcloud.path;
            dbtype = "pgsql";
            dbhost = "/run/postgresql";
            dbname = "nextcloud";
            defaultPhoneRegion = "NZ";
          };
          nginx.recommendedHttpHeaders = true;
          https = true;
          phpOptions = {
            "opcache.interned_strings_buffer" = "16";
            "output_buffering" = "off";
          };
        };
        postgresql = {
          enable = true;
          ensureDatabases = [config.services.nextcloud.config.dbname];
          ensureUsers = [
            {
              name = config.services.nextcloud.config.dbuser;
              ensureDBOwnership = true;
            }
          ];
        };
        nginx.virtualHosts."${domain}" = {
          forceSSL = true;
          enableACME = true;
          http2 = true;
        };
      };
      systemd.services."nextcloud-setup" = {
        requires = ["postgresql.service"];
        after = ["postgresql.service"];
      };
    };
}
