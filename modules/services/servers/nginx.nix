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
    servers.nginx = cutelib.mkEnable;
    web.matrix-client = {
      enable = cutelib.mkEnable;
      package = lib.mkOption {
        type = lib.types.package;
        default = pkgs.element-web;
      };
    };
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
    mkIf config.cute.services.servers.nginx {
      services.nginx = {
        enable = true;
        virtualHosts = mkMerge [
          (genHosts [
            "audiobookshelf"
            "jellyfin"
            "jellyseerr"
            "komga"
            "mealie"
            "navidrome"
            "vaultwarden"
          ])
          (
            let
              inherit
                (config.cute.services.web)
                audiobookshelf
                jellyfin
                matrix-client
                navidrome
                nextcloud
                vaultwarden
                ;
            in {
              "${domain}" = {
                root = "/storage/website/cafe";
                inherit forceSSL enableACME;
                locations = mkIf config.cute.services.minecraft.enable {
                  "/paguicon".tryFiles = "/paguicon.jpg $uri";
                  "/pagupack".tryFiles = "/pagupack.mrpack $uri";
                };
              };
              "jlly.${domain}".locations."/" = mkIf jellyfin.enable {
                proxyWebsockets = true;
                extraConfig = "proxy_buffering off;";
              };
              "chat.${domain}" = mkIf matrix-client.enable {
                root = matrix-client.package;
                inherit forceSSL enableACME;
              };
              "shlf.${domain}".locations."/".proxyWebsockets = mkIf audiobookshelf.enable true;
              "navi.${domain}".locations."/".proxyWebsockets = mkIf navidrome.enable true;
              "next.${domain}" = mkIf nextcloud.enable {inherit forceSSL enableACME;};
              "wrdn.${domain}".locations."/".extraConfig = mkIf vaultwarden.enable "proxy_pass_header Authorization;";
            }
          )
        ];
        recommendedGzipSettings = true;
        recommendedOptimisation = true;
        recommendedProxySettings = true;
        recommendedTlsSettings = true;
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
