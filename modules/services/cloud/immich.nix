{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.services.cloud.immich = cutelib.mkEnable;
  config = lib.mkIf config.cute.services.cloud.immich {
    services = let
      port = 3001;
    in {
      immich = {
        enable = true;
        inherit port;
        openFirewall = true;
        host = "0.0.0.0";
        mediaLocation = "/storage/immich";
        environment.TZ = "NZ";
        machine-learning.enable = false;
      };
      nginx = cutelib.host "pics" port "true" "client_max_body_size 50000M;";
    };
  };
}
