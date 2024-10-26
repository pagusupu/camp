{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.services.cloud.immich = cutelib.mkEnable;
  config = lib.mkIf config.cute.services.cloud.immich {
    services = {
      immich = {
        enable = true;
        port = 3001;
        openFirewall = true;
        host = "0.0.0.0";
        mediaLocation = "/storage/services/immich";
        environment.TZ = "NZ";
        machine-learning.enable = false;
      };
      nginx.virtualHosts."pics.pagu.cafe" = {
        locations."/" = {
          proxyPass = "http://localhost:3001";
          proxyWebsockets = true;
          extraConfig = "client_max_body_size 50000M;";
        };
        enableACME = true;
        forceSSL = true;
      };
    };
  };
}
