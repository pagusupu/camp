{
  config,
  lib,
  _lib,
  pkgs,
  ...
}: {
  options.cute.services.matrix = {
    cinny = lib.mkEnableOption "";
    synapse = lib.mkEnableOption "";
  };
  config = let
    inherit (config.networking) domain;
    inherit (config.cute.services.matrix) cinny synapse;
    c = {
      forceSSL = true;
      enableACME = true;
    };
  in
    lib.mkMerge [
      (lib.mkIf cinny {
        services.nginx.virtualHosts."ciny.${domain}" = {root = pkgs.cinny;} // c;
        assertions = [
          {
            assertion = config.cute.services.matrix.synapse;
            message = "requires synapse service";
          }
        ];
      })
      (lib.mkIf synapse {
        assertions = _lib.assertNginx;
        age.secrets.synapse = {
          file = ../../misc/secrets/synapse.age;
          owner = "matrix-synapse";
        };
        services = {
          matrix-synapse = {
            enable = true;
            settings = {
              server_name = domain;
              withJemalloc = true;
              url_preview_enabled = true;
              max_upload_size = "10G";
              registration_shared_secret_path = config.age.secrets.synapse.path;
              registration_requires_token = true;
              listeners = [
                {
                  port = 8008;
                  bind_addresses = ["0.0.0.0"];
                  type = "http";
                  tls = false;
                  x_forwarded = true;
                  resources = [
                    {
                      names = ["client" "federation"];
                      compress = true;
                    }
                  ];
                }
              ];
            };
          };
          nginx.virtualHosts = {
            "matrix.${domain}" =
              {
                root = /storage/website/matrix;
                locations = {
                  "/_matrix".proxyPass = "http://127.0.0.1:8008";
                  "/_synapse".proxyPass = "http://127.0.0.1:8008";
                };
              }
              // c;
            "${domain}".locations = let
              formatJson = pkgs.formats.json {};
              extraConfig = ''
                default_type application/json;
                add_header Access-Control-Allow-Origin "*";
              '';
            in {
              "=/.well-known/matrix/server" = {
                alias = formatJson.generate "well-known-matrix-server" {
                  "m.server" = "matrix.${domain}:443";
                };
                inherit extraConfig;
              };
              "=/.well-known/matrix/client" = {
                alias = formatJson.generate "well-known-matrix-client" {
                  "m.homeserver" = {"base_url" = "https://matrix.${domain}";};
                  "org.matrix.msc3575.proxy" = {"url" = "https://matrix.${domain}";};
                };
                inherit extraConfig;
              };
            };
          };
          postgresql = {
            enable = true;
            initialScript = pkgs.writeText "synapse-init.sql" ''
              CREATE DATABASE "matrix-synapse" WITH OWNER "matrix-synapse"
              TEMPLATE template0
              LC_COLLATE = "C"
              LC_CTYPE = "C";
            '';
          };
        };
      })
    ];
}
