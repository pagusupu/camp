{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.services.web.linkding = cutelib.mkWebOpt "link" 9090;
  config = let
    inherit (config.cute.services.web.linkding) enable port;
    inherit (builtins) toString;
  in
    lib.mkIf enable (
      lib.mkMerge [
        {assertions = cutelib.assertNginx "linkding";}
        {
          assertions = cutelib.assertDocker "linkding";
          virtualisation.oci-containers.containers."linkding" = {
            image = "sissbruecker/linkding:latest";
            ports = ["${toString port}:${toString port}"];
            volumes = ["/storage/services/linkding/:/etc/linkding/data"];
            environment = {
              LD_SUPERUSER_NAME = "pagu";
              LD_SUPERUSER_PASSWORD = "changeme";
            };
          };
        }
      ]
    );
}
