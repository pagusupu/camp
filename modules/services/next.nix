{
  config,
  pkgs,
  lib,
  ...
}: {
  options.cute.services.next = lib.mkEnableOption "";
  config = let
    domain = "${config.cute.services.nginx.domain}";
  in
    lib.mkIf config.cute.services.next {
      age.secrets.nextcloud = {
        file = ../../secrets/nextcloud.age;
        owner = "nextcloud";
      };
      services = {
        nextcloud = {
          enable = true;
          package = pkgs.nextcloud28;
          hostName = "next.${domain}";
          https = true;
          nginx.recommendedHttpHeaders = true;
          configureRedis = true;
          config = {
            adminuser = "pagu";
            adminpassFile = config.age.secrets.nextcloud.path;
            dbtype = "pgsql";
            dbname = "nextcloud";
            dbhost = "/run/postgresql";
          };
          extraOptions = {
            overwriteProtocol = "https";
            extraTrustedDomains = ["https://next.${domain}"];
            trustedProxies = ["https://next.${domain}"];
            defaultPhoneRegion = "NZ";
            #     mail_smtpmode = "smtp";
            #     mail_sendmailmode = "smtp";
            #     mail_smtpsecure = "ssl";
            #     mail_smtphost = "mail.${domain}";
            #     mail_smtpport = "465";
            #     mail_smtpauth = 1;
            #     mail_smtpname = "cloud@${domain}";
            #     mail_from_address = "cloud";
            #     mail_domain = "${domain};
          };
          phpOptions = {
            "opcache.interned_strings_buffer" = "16";
            "output_buffering" = "off";
          };
          home = "/storage/services/nextcloud";
          #  autoUpdateApps.enable = true;
          #     extraAppsEnable = true;
          #     extraApps = {
          #       inherit (pkgs.nextcloud28Packages.apps) mail calendar notes;
          #     };
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
        nginx.virtualHosts."next.${domain}" = {
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
