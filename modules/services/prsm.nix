{
  config,
  lib,
  pkgs,
  ...
}: {
  options.cute.services.prsm = lib.mkEnableOption "";
  config = lib.mkIf config.cute.services.prsm {
    age.secrets.photoprism = {
      file = ../../secrets/photoprism.age;
    };
    services = {
      photoprism = rec {
        enable = true;
        address = "0.0.0.0";
        storagePath = "/storage/services/photoprism";
        originalsPath = "/storage/services/photoprism/originals";
        importPath = originalsPath;
        passwordFile = config.age.secrets.photoprism.path;
        settings = {
          PHOTOPRISM_ADMIN_USER = "pagu";
          PHOTOPRISM_DISABLE_PLACES = "true";
          PHOTOPRISM_DISABLE_FACES = "true";
          PHOTOPRISM_UPLOAD_NSFW = "true";
          PHOTOPRISM_DATABASE_NAME = "photoprism";
          PHOTOPRISM_DATABASE_USER = "photoprism";
          PHOTOPRISM_DATABASE_SERVER = "/run/mysqld/mysqld.sock";
          PHOTOPRISM_DATABASE_DRIVER = "mysql";
        };
      };
      mysql = {
        enable = true;
        package = pkgs.mariadb;
        ensureDatabases = ["photoprism"];
        ensureUsers = [
          {
            name = "photoprism";
            ensurePermissions."photoprism.*" = "ALL PRIVILEGES";
          }
        ];
      };
      nginx = {
        virtualHosts."prsm.${config.networking.domain}" = {
          enableACME = true;
          forceSSL = true;
          http2 = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:2342";
            proxyWebsockets = true;
            extraConfig = ''
              proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
              proxy_set_header Host $host;
              proxy_buffering off;
              client_max_body_size 500M;
            '';
          };
        };
      };
    };
    fileSystems = {
      "/var/lib/private/photoprism" = {
        device = "/data/photoprism";
        options = ["bind"];
      };
      "/var/lib/private/photoprism/originals" = {
        device = "/data/originals";
        options = ["bind"];
      };
    };
  };
}
