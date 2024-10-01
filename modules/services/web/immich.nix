{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.services.web.immich = cutelib.mkWebOpt "pics" 3001;
  config = lib.mkIf config.cute.services.web.immich.enable {
    services.immich = {
      enable = true;
      openFirewall = true;
      host = "0.0.0.0";
      mediaLocation = "/storage/services/immich";
      environment.TZ = "NZ";
      machine-learning.enable = false;
    };
    cute.services = {
      web.immich = {
        extraSettings = {
          enable = true;
          text = "client_max_body_size 50000M;";
        };
        websocket = true;
      };
      servers.nginx.hosts = ["immich"];
    };
  };
}
