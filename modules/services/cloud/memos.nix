{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.services.cloud.memos = cutelib.mkEnable;
  config = lib.mkIf config.cute.services.cloud.memos (lib.mkMerge [
    { assertions = cutelib.assertNginx "memos"; }
    (let
      port = 5230;
    in {
      assertions = cutelib.assertDocker "memos";
      virtualisation.oci-containers.containers."memos" = {
        image = "neosmemo/memos:stable";
        ports = [ "${builtins.toString port}:5230" ];
        volumes = [ "/storage/memos/:/var/opt/memos" ];
      };
      services.nginx = cutelib.host "memo" port "" "";
    })
  ]);
}
