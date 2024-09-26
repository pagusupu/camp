{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.services.web.memos = cutelib.mkWebOpt "memo" 5230;
  config = let
    inherit (config.cute.services.web.memos) enable port;
  in
    lib.mkIf enable {
      virtualisation.oci-containers.containers."memos" = {
        image = "neosmemo/memos:stable";
        ports = ["${builtins.toString port}:5230"];
        volumes = ["/storage/services/memos/:/var/opt/memos"];
      };
    };
}
