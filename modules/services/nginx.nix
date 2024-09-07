{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkMerge;
  inherit (config.networking) domain;
in {
  options.cute.services = {
    nginx = cutelib.mkEnable;
    web.element.enable = cutelib.mkEnable;
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
            "mealie"
            "navidrome"
            "qbittorrent"
            "vaultwarden"
          ])
          (
            let
              inherit
                (config.cute.services.web)
                element
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
              "chat.${domain}" = mkIf element.enable {
                root = pkgs.element-web;
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
