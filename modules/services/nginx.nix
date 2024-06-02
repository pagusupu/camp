{
  config,
  lib,
  _lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkMerge;
  inherit (_lib) genAttrs';
  inherit (builtins) toString;
  inherit (config.networking) domain;
in {
  options.cute.services = {
    nginx = mkEnableOption "";
    web.cinny.enable = mkEnableOption "";
  };
  config = mkIf config.cute.services.nginx {
    services.nginx = {
      enable = true;
      virtualHosts = let
        forceSSL = true;
        enableACME = true;
        genHosts = i:
          genAttrs' i (
            x: let
              inherit (config.cute.services.web.${x}) enable dns port;
            in {
              name = "${dns}.${domain}";
              value = {
                locations."/".proxyPass = lib.mkIf enable "http://localhost:${toString port}";
                inherit forceSSL enableACME;
              };
            }
          );
      in
        mkMerge [
          (genHosts [
            "jellyfin"
            "komga"
            "linkding"
            "navidrome"
            "qbittorrent"
            "vaultwarden"
          ])
          {
            "navi.${domain}".locations."/".proxyWebsockets = true;
            "next.${domain}" = mkIf config.cute.services.web.nextcloud.enable {inherit forceSSL enableACME;};
            "wrdn.${domain}".locations."/".extraConfig = "proxy_pass_header Authorization;";
            "ciny.${domain}" = mkIf config.cute.services.web.cinny.enable {
              root = pkgs.cinny;
              inherit forceSSL enableACME;
            };
            "jlly.${domain}".locations."/" = {
              proxyWebsockets = true;
              extraConfig = "proxy_buffering off;";
            };
            "matrix.${domain}" = mkIf config.cute.services.synapse {
              root = /storage/website/matrix;
              locations = {
                "/_matrix".proxyPass = "http://127.0.0.1:8008";
                "/_synapse".proxyPass = "http://127.0.0.1:8008";
              };
              inherit forceSSL enableACME;
            };
            "${domain}" = {
              root = "/storage/website/cafe";
              locations = let
                extraConfig = ''
                  default_type application/json;
                  add_header Access-Control-Allow-Origin "*";
                '';
              in
                mkIf config.cute.services.synapse {
                  "=/.well-known/matrix/server" = {
                    alias = (pkgs.formats.json {}).generate "well-known-matrix-server" {
                      "m.server" = "matrix.${domain}:443";
                    };
                    inherit extraConfig;
                  };
                  "=/.well-known/matrix/client" = {
                    alias = (pkgs.formats.json {}).generate "well-known-matrix-client" {
                      "m.homeserver"."base_url" = "https://matrix.${domain}";
                      "org.matrix.msc3575.proxy"."url" = "https://matrix.${domain}";
                    };
                    inherit extraConfig;
                  };
                };
              inherit forceSSL enableACME;
            };
          }
        ];
      recommendedBrotliSettings = true;
      recommendedGzipSettings = true;
      recommendedOptimisation = true;
      recommendedProxySettings = true;
      recommendedTlsSettings = true;
      recommendedZstdSettings = true;
      commonHttpConfig = ''
        real_ip_header CF-Connecting-IP;
        add_header 'Referrer-Policy' 'origin-when-cross-origin';
      '';
    };
    security.acme = {
      acceptTerms = true;
      defaults.email = "amce@${domain}";
    };
    users.users.nginx.extraGroups = ["acme"];
    networking.firewall.allowedTCPPorts = [80 443];
  };
}
