{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.services.cloud.memos = cutelib.mkEnable;
  config = lib.mkIf config.cute.services.cloud.memos (lib.mkMerge [
    {assertions = cutelib.assertNginx "memos";}
    {
      assertions = cutelib.assertDocker "memos";
      virtualisation.oci-containers.containers."memos" = {
        image = "neosmemo/memos:stable";
        ports = ["5230:5230"];
        volumes = ["/storage/services/memos/:/var/opt/memos"];
      };
      services.nginx.virtualHosts."memo.pagu.cafe" = {
        enableACME = true;
        forceSSL = true;
        locations."/".proxyPass = "http://localhost:5230";
      };
    }
  ]);
}
