{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}: let
  inherit (cutelib) mkEnable;
  inherit (lib) mkOption types mkIf mkMerge;
  inherit (config.networking) domain;
in {
  options.cute.services = {
    servers = {
      nginx = {
        enable = mkEnable;
        hosts = mkOption {
          type = types.listOf types.str;
          default = [];
        };
      };
      docker = mkEnable;
    };
    web.matrix-client = {
      enable = mkEnable;
      package = mkOption {
        type = types.package;
        default = pkgs.element-web;
      };
    };
  };
  config = let
    inherit (config.cute.services.servers) nginx docker;
  in
    lib.mkMerge [
      (let
        forceSSL = true;
        enableACME = true;
        genHosts = let
          genAttrs' = list: f: lib.listToAttrs (map f list);
        in
          i:
            genAttrs' i (
              x: let
                inherit
                  (config.cute.services.web.${x})
                  enable
                  dns
                  port
                  websocket
                  extraSettings
                  ;
              in {
                name = "${dns}.${domain}";
                value = {
                  locations."/" = {
                    proxyPass = lib.mkIf enable "http://localhost:${builtins.toString port}";
                    proxyWebsockets = lib.mkIf websocket true;
                    extraConfig = mkIf extraSettings.enable "${extraSettings.text}";
                  };
                  inherit forceSSL enableACME;
                };
              }
            );
      in
        mkIf nginx.enable {
          services.nginx = {
            enable = true;
            virtualHosts = mkMerge [
              {
                "${domain}" = {
                  root = "/storage/website/cafe";
                  locations = {
                    "/paguicon".tryFiles = "/paguicon.jpg $uri";
                    "/pagupack".tryFiles = "/pagupack.mrpack $uri";
                  };
                  inherit forceSSL enableACME;
                };
                "chat.${domain}" = let
                  inherit (config.cute.services.web.matrix-client) enable package;
                in
                  mkIf enable {
                    root = package;
                    inherit forceSSL enableACME;
                  };
              }
              (genHosts config.cute.services.servers.nginx.hosts)
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
        })
      (mkIf docker {
        virtualisation = {
          docker = {
            enable = true;
            storageDriver = "btrfs";
          };
          oci-containers.backend = "docker";
        };
      })
    ];
}
