{
  config,
  lib,
  pkgs,
  ...
}: {
  options.cute.services.synapse = lib.mkEnableOption "";
  config = lib.mkIf config.cute.services.synapse {
    age.secrets.synapse = {
      file = ../../secrets/synapse.age;
      owner = "matrix-synapse";
    };
    services = {
      matrix-synapse = {
        enable = true;
        settings = {
          server_name = config.cute.services.nginx.domain;
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
      nginx = {
        virtualHosts = let
          domain = "${config.cute.services.nginx.domain}";
        in {
          "matrix.${domain}" = {
            forceSSL = true;
            enableACME = true;
	    root = /storage/website/matrix;
            locations = {
              "/_matrix".proxyPass = "http://127.0.0.1:8008";
              "/_synapse".proxyPass = "http://127.0.0.1:8008";
            };
          };
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
          "elmt.${domain}" = {
            enableACME = true;
            forceSSL = true;
            root = pkgs.element-web;
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
  };
}
