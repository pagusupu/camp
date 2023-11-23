{
  config,
  pkgs,
  lib,
  ...
}: {
  options.cute.services.nextcloud = {
    enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.cute.services.nextcloud.enable {
    age.secrets.nextcloud = {
      file = ../../secrets/nextcloud.age;
      owner = "nextcloud";
    };
    services = {
      nextcloud = {
        enable = true;
        package = pkgs.nextcloud27;
        hostName = "cloud.pagu.cafe";
        home = "/mnt/storage/services/nextcloud";
        autoUpdateApps.enable = true;
        configureRedis = true;
        config = {
          overwriteProtocol = "https";
          extraTrustedDomains = ["https://cloud.pagu.cafe"];
          trustedProxies = ["https://cloud.pagu.cafe"];
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
        };
      };
      postgresql = {
        enable = true;
        ensureDatabases = [config.services.nextcloud.config.dbname];
        ensureUsers = [
          {
            name = config.services.nextcloud.config.dbuser;
            ensurePermissions."DATABASE ${config.services.nextcloud.config.dbname}" = "ALL PRIVILEGES";
          }
        ];
      };
    };
    systemd.services."nextcloud-setup" = {
      requires = ["postgresql.service"];
      after = ["postgresql.service"];
    };
  };
}
