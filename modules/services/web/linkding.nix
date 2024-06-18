{
  config,
  lib,
  _lib,
  ...
}: {
  options.cute.services.web.linkding = _lib.mkWebOpt "link" 9090;
  config = let
    inherit (lib) mkMerge mkIf;
    inherit (builtins) toString;
    inherit (config.cute.services.web.linkding) enable port;
  in
    mkMerge [
      (mkIf enable {assertions = _lib.assertNginx;})
      (mkIf enable {
        assertions = _lib.assertDocker;
        virtualisation.oci-containers.containers."linkding" = {
          image = "sissbruecker/linkding:latest";
          ports = ["${toString port}:${toString port}"];
          volumes = ["/storage/services/linkding/:/etc/linkding/data"];
          environmentFiles = [config.age.secrets.linkding.path];
        };
        age.secrets.linkding.file = ../../../misc/secrets/linkding.age;
      })
    ];
}
