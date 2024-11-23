{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.services.cloud.linkding = cutelib.mkEnable;
  config = lib.mkIf config.cute.services.cloud.linkding (lib.mkMerge [
    { assertions = cutelib.assertNginx "linkding"; }
    (let
      port = 9090;
    in {
      assertions = cutelib.assertDocker "linkding";
      virtualisation.oci-containers.containers."linkding" = {
        image = "sissbruecker/linkding:latest";
        ports = [ "${builtins.toString port}:9090" ];
        volumes = [ "/storage/linkding/:/etc/linkding/data" ];
        environment = {
          LD_SUPERUSER_NAME = "pagu";
          LD_SUPERUSER_PASSWORD = "changeme"; # initial
        };
      };
      services.nginx = cutelib.host "link" port "" "";
    })
  ]);
}
