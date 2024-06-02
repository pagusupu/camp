{
  config,
  lib,
  _lib,
  ...
}: {
  options.cute.services.web.linkding = _lib.mkWebOpt "link" 9090;
  config = let
    inherit (builtins) toString;
    inherit (config.cute.services.web.linkding) enable port;
  in
    lib.mkIf enable {
      assertions = [
        {
          assertion = config.cute.services.docker.enable;
          message = "requires docker service.";
        }
        {
          assertion = config.cute.services.nginx;
          message = "requires nginx service.";
        }
      ];
      virtualisation.oci-containers.containers."linkding" = {
        image = "sissbruecker/linkding:latest";
        ports = ["${toString port}:${toString port}"];
        volumes = ["/storage/services/linkding/:/etc/linkding/data"];
        environmentFiles = [config.age.secrets.linkding.path];
      };
      age.secrets.linkding.file = ../../../misc/secrets/linkding.age;
    };
}
