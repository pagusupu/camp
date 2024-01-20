{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.cute.services.web.conduit = lib.mkEnableOption "";
  config = let
    matrix_domain = "matrix.${config.cute.services.web.domain}";
    domain = "${config.cute.services.web.domain}";
  in
    lib.mkIf config.cute.services.web.conduit {
      services = {
        matrix-conduit = {
          enable = true;
          package = inputs.conduit.packages.${pkgs.system}.default;
          settings.global = {
            inherit domain;
            address = "0.0.0.0";
          };
        };
        nginx = {
          virtualHosts = {
            "${matrix_domain};" = {
              forceSSL = true;
              enableACME = true;
              listen = [
                {
                  addr = "0.0.0.0";
                  port = 80;
                  ssl = true;
                }
                {
                  addr = "0.0.0.0";
                  port = 443;
                  ssl = true;
                }
                {
                  addr = "0.0.0.0";
                  port = 8448;
                  ssl = true;
                }
              ];
              locations."/_matrix/" = {
                proxyPass = "http://backend_conduit$request_uri";
                proxyWebsockets = true;
                extraConfig = ''
                  proxy_set_header Host $host;
                  proxy_buffering off;
                '';
              };
              extraConfig = ''merge_slashes = off;'';
            };
            "${domain}".locations = let
              formatJson = pkgs.formats.json {};
            in {
              "=/.well-known/matrix/server" = {
                alias = formatJson.generate "well-known-matrix-server" {
                  "m.server" = "${matrix_domain}";
                };
                extraConfig = ''
                  default_type application/json;
                  add_header Access-Control-Allow-Origin "*";
                '';
              };
              "=/.well-known/matrix/client" = {
                alias = formatJson.generate "well-known-matrix-client" {
                  "m.homeserver" = {
                    "base_url" = "https://${matrix_domain}";
                  };
                  "org.matrix.msc3575.proxy" = {
                    "url" = "https://${matrix_domain}";
                  };
                };
                extraConfig = ''
                  default_type application/json;
                  add_header Access-Control-Allow-Origin "*";
                '';
              };
            };
          };
          upstreams."backend_conduit".servers = {
            "[::1]:${toString config.services.matrix-conduit.settings.global.port}" = {};
          };
        };
      };
      networking.firewall.allowedTCPPorts = [8448];
      networking.firewall.allowedUDPPorts = [8448];
    };
}
