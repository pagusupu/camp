{
  config,
  lib,
  _lib,
  ...
}: {
  options.cute.services.web.linkding = _lib.mkWebOpt "link" 9090;
  config = let
    inherit (config.cute.services.web.linkding) enable port;
    inherit (builtins) toString;
  in
    lib.mkIf enable (
      lib.mkMerge [
        {assertions = _lib.assertNginx "linkding";}
        {
          assertions = _lib.assertDocker "linkding";
          virtualisation.oci-containers.containers."linkding" = {
            image = "sissbruecker/linkding:latest";
            ports = ["${toString port}:${toString port}"];
            volumes = ["/storage/services/linkding/:/etc/linkding/data"];
            environmentFiles = [config.age.secrets.linkding.path];
          };
          age.secrets.linkding.file = ../../../misc/secrets/linkding.age;
        }
      ]
    );
}
