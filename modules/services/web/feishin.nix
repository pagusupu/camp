{
  config,
  lib,
  _lib,
  ...
}: {
  options.cute.services.web.feishin = _lib.mkWebOpt "fish" 9180;
  config = let
    inherit (config.cute.services.web.feishin) enable port;
    inherit (builtins) toString;
  in
    lib.mkIf enable (
      lib.mkMerge [
        {assertions = _lib.assertNginx "feishin";}
        {
          assertions = _lib.assertDocker "feishin";
          virtualisation.oci-containers.containers."feishin" = {
            image = "ghcr.io/jeffvli/feishin:0.7.3";
            ports = ["${toString port}:${toString port}"];
            environment = {
              SERVER_NAME = "navi";
              SERVER_TYPE = "navidrome";
            };
          };
        }
      ]
    );
}
