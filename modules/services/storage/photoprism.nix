{
  config,
  lib,
  pkgs,
  ...
}: {
  options.cute.services.storage.photoprism = lib.mkEnableOption "";
  config = let
    prismpath = "/storage/services/photoprism";
  in
    lib.mkIf config.cute.services.storage.photoprism {
      age.secrets.photoprism = {
        file = ../../../misc/secrets/photoprism.age;
      };
      services = {
        photoprism = {
          enable = true;
          address = "0.0.0.0";
          storagePath = prismpath;
          originalsPath = prismpath + "/originals";
          #importPath = prismpath + "/imports";
          passwordFile = config.age.secrets.photoprism.path;
          settings = {
            PHOTOPRISM_ADMIN_USER = "pagu";
            #PHOTOPRISM_ADMIN_PASSWORD = "temp";
            PHOTOPRISM_DISABLE_PLACES = "true";
            PHOTOPRISM_DISABLE_FACES = "true";
            PHOTOPRISM_UPLOAD_NSFW = "true";
            PHOTOPRISM_DATABASE_NAME = "photoprism";
            PHOTOPRISM_DATABASE_USER = "photoprism";
            PHOTOPRISM_DATABASE_SERVER = "/run/mysqld/mysqld.sock";
            PHOTOPRISM_DATABASE_DRIVER = "mysql";
            #PHOTOPRISM_AUTH_MODE = "public";
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
            #http2 = true;
            locations."/" = {
              proxyPass = "http://127.0.0.1:2342";
              proxyWebsockets = true;
              extraConfig = ''
                proxy_set_header Upgrade $http_upgrade;
                proxy_set_header Connection "upgrade";
                proxy_buffering off;
                client_max_body_size 500M;
              '';
            };
          };
        };
      };
      fileSystems = {
        "/var/lib/private/photoprism" = {
          device = prismpath;
          options = ["bind"];
        };
        "/var/lib/private/photoprism/originals" = {
          device = prismpath + "/originals";
          options = ["bind"];
        };
      };
      environment.systemPackages = [pkgs.photoprism];
    };
}
