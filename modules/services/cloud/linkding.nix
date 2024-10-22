{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.services.cloud.linkding = cutelib.mkEnable;
  config = lib.mkIf config.cute.services.cloud.linkding (lib.mkMerge [
    {assertions = cutelib.assertNginx "linkding";}
    {
      assertions = cutelib.assertDocker "linkding";
      virtualisation.oci-containers.containers."linkding" = {
        image = "sissbruecker/linkding:latest";
        ports = ["9090:9090"];
        volumes = ["/storage/services/linkding/:/etc/linkding/data"];
        environment = {
          LD_SUPERUSER_NAME = "pagu";
          LD_SUPERUSER_PASSWORD = "changeme"; # initial
        };
      };
      services.nginx.virtualHosts."link.pagu.cafe" = {
        enableACME = true;
        forceSSL = true;
        locations."/".proxyPass = "http://localhost:9090";
      };
    }
  ]);
}
