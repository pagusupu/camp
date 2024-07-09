{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkIf mkMerge;
  inherit (config.networking) domain;
in {
  options.cute.services = {
    nginx = mkEnableOption "";
    web.cinny.enable = mkEnableOption "";
  };
  config = let
    forceSSL = true;
    enableACME = true;
    genHosts = let
      genAttrs' = list: f: lib.listToAttrs (map f list);
    in
      i:
        genAttrs' i (
          x: let
            inherit (config.cute.services.web.${x}) enable dns port;
          in {
            name = "${dns}.${domain}";
            value = {
              locations."/".proxyPass = lib.mkIf enable "http://localhost:${builtins.toString port}";
              inherit forceSSL enableACME;
            };
          }
        );
  in
    mkIf config.cute.services.nginx {
      services.nginx = {
        enable = true;
        virtualHosts = mkMerge [
          (genHosts [
            "jellyfin"
            "komga"
            "linkding"
            "navidrome"
            "qbittorrent"
            "vaultwarden"
          ])
          (
            let
              inherit
                (config.cute.services.web)
                cinny
                jellyfin
                navidrome
                nextcloud
                vaultwarden
                ;
            in {
              "${domain}" = {
                root = "/storage/website/cafe";
                inherit forceSSL enableACME;
              };
              "ciny.${domain}" = mkIf cinny.enable {
                root = pkgs.cinny;
                inherit forceSSL enableACME;
              };
              "jlly.${domain}".locations."/" = mkIf jellyfin.enable {
                proxyWebsockets = true;
                extraConfig = "proxy_buffering off;";
              };
              "navi.${domain}".locations."/".proxyWebsockets = mkIf navidrome.enable true;
              "next.${domain}" = mkIf nextcloud.enable {inherit forceSSL enableACME;};
              "wrdn.${domain}".locations."/".extraConfig = mkIf vaultwarden.enable "proxy_pass_header Authorization;";
            }
          )
          (mkIf config.cute.services.synapse {
            "matrix.${domain}" = {
              # root = /storage/website/matrix;
              # colmena wont build with this?
              locations = {
                "/_matrix".proxyPass = "http://127.0.0.1:8008";
                "/_synapse".proxyPass = "http://127.0.0.1:8008";
              };
              inherit forceSSL enableACME;
            };
            "${domain}" = {
              locations = let
                extraConfig = ''
                  default_type application/json;
                  add_header Access-Control-Allow-Origin "*";
                '';
                json = pkgs.formats.json {};
              in
                mkIf config.cute.services.synapse {
                  "=/.well-known/matrix/server" = {
                    alias = json.generate "well-known-matrix-server" {
                      "m.server" = "matrix.${domain}:443";
                    };
                    inherit extraConfig;
                  };
                  "=/.well-known/matrix/client" = {
                    alias = json.generate "well-known-matrix-client" {
                      "m.homeserver"."base_url" = "https://matrix.${domain}";
                      "org.matrix.msc3575.proxy"."url" = "https://matrix.${domain}";
                    };
                    inherit extraConfig;
                  };
                };
            };
          })
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
