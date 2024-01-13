{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: {
  options.cute.services.conduit.enable = lib.mkEnableOption "";
  config = let
    domain = "matrix.${config.cute.services.nginx.domain}";
    baseDomain = "${config.cute.services.nginx.domain}";
    well_known_server = pkgs.writeText "well-known-matrix-server" ''
      {
        "m.server": "${domain}"
      }
    '';
    well_known_client = pkgs.writeText "well-known-matrix-client" ''
      {
        "m.homeserver": {
          "base_url": "https://${domain}"
        }
      }
    '';
  in
    lib.mkIf config.cute.services.conduit.enable {
      services = {
        matrix-conduit = {
          enable = true;
          package = inputs.conduit.packages.${pkgs.system}.default;
          settings.global = {inherit baseDomain;
	  };
        };
        nginx = {
          virtualHosts = {
            "${domain};" = {
              forceSSL = true;
              enableACME = true;
              listen = [
                {
                  addr = "0.0.0.0";
                  port = 443;
                  ssl = true;
                }
                {
                  addr = "[::]";
                  port = 443;
                  ssl = true;
                }
		{
		  addr = "0.0.0.0";
		  port = 8448;
		  ssl = true;
		}
                {
                  addr = "[::]";
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
              extraConfig = ''
                merge_slashes = off;
              '';
            };
            "${baseDomain}" = {
	      forceSSL = true;
	      enableACME = true;
              locations."=./well-known/matrix/server" = {
                alias = "${well_known_server}";
                extraConfig = ''
                  default_type application/json;
                '';
              };
              locations."/.well-known/matrix/client" = {
                alias = "${well_known_client}";
                extraConfig = ''
                  default_type application/json;
                  add_header Access-Control-Allow-Origin "*";
                '';
              };
            };
          };
          upstreams = {
            "backend_conduit" = {
              servers = {
                "[::1]:${toString config.services.matrix-conduit.settings.global.port}" = {};
              };
            };
          };
        };
      };
    };
}
