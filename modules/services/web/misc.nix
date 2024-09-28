{
  config,
  lib,
  cutelib,
  ...
}: let
  inherit (cutelib) mkWebOpt assertNginx assertDocker;
  inherit (lib) mkMerge mkIf;
in {
  options.cute.services.web = {
    linkding = mkWebOpt "link" 9090;
    mealie = mkWebOpt "meal" 9000;
    memos = mkWebOpt "memo" 5230;
  };
  config = let
    inherit (config.cute.services.web) linkding mealie memos;
  in
    mkMerge [
      (let
        inherit (linkding) enable port;
      in
        mkIf enable (mkMerge [
          {assertions = assertNginx "linkding";}
          {
            assertions = assertDocker "linkding";
            virtualisation.oci-containers.containers."linkding" = {
              image = "sissbruecker/linkding:latest";
              ports = ["${builtins.toString port}:9090"];
              volumes = ["/storage/services/linkding/:/etc/linkding/data"];
              environment = {
                LD_SUPERUSER_NAME = "pagu";
                LD_SUPERUSER_PASSWORD = "changeme";
              };
            };
            cute.services.servers.nginx.hosts = ["linkding"];
          }
        ]))
      (let
        inherit (mealie) enable port dns;
      in
        mkIf enable {
          assertions = assertNginx "mealie";
          services.mealie = {
            inherit enable port;
            settings = {
              BASE_URL = "${dns}.${config.networking.domain}";
              TZ = "NZ";
            };
          };
          fileSystems."/var/lib/private/mealie" = {
            device = "/storage/services/mealie";
            options = ["bind"];
          };
          cute.services.servers.nginx.hosts = ["mealie"];
        })
      (let
        inherit (memos) enable port;
      in
        mkIf enable (mkMerge [
          {assertions = assertNginx "memos";}
          {
            assertions = assertDocker "memos";
            virtualisation.oci-containers.containers."memos" = {
              image = "neosmemo/memos:stable";
              ports = ["${builtins.toString port}:5230"];
              volumes = ["/storage/services/memos/:/var/opt/memos"];
            };
            cute.services.servers.nginx.hosts = ["memos"];
          }
        ]))
    ];
}
