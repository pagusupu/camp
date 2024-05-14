{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkMerge mkIf;
in {
  options.cute.services.docker = {
    enable = mkEnableOption "";
    feishin = mkEnableOption "";
    linkding = mkEnableOption "";
    memos = mkEnableOption "";
    multi-scrobbler = mkEnableOption "";
  };
  config = let
    inherit (config.networking) domain;
    inherit (config.cute.services.docker) enable feishin linkding memos multi-scrobbler;
    common = {
      forceSSL = true;
      enableACME = true;
    };
  in
    mkMerge [
      (mkIf enable {
        virtualisation = {
          docker = {
            enable = true;
            storageDriver = "btrfs";
          };
          oci-containers.backend = "docker";
        };
      })
      (mkIf feishin {
        virtualisation.oci-containers.containers."feishin" = {
          image = "ghcr.io/jeffvli/feishin:0.7.1";
          ports = ["9180:9180"];
        };
        services.nginx.virtualHosts."fish.${domain}" = {locations."/".proxyPass = "http://127.0.0.1:9180";} // common;
      })
      (mkIf linkding {
        age.secrets.linkding.file = ../../misc/secrets/linkding.age;
        virtualisation.oci-containers.containers."linkding" = {
          image = "sissbruecker/linkding:latest";
          ports = ["9090:9090"];
          volumes = ["/storage/services/linkding/:/etc/linkding/data"];
          environmentFiles = [config.age.secrets.linkding.path];
        };
        services.nginx.virtualHosts."link.${domain}" = {locations."/".proxyPass = "http://127.0.0.1:9090";} // common;
      })
      (mkIf memos {
        virtualisation.oci-containers.containers."memos" = {
          image = "neosmemo/memos:stable";
          ports = ["5230:5230"];
          volumes = ["/storage/services/memos/:/var/opt/memos"];
        };
        services.nginx.virtualHosts."memo.${domain}" = {locations."/".proxyPass = "http://127.0.0.1:5230";} // common;
      })
      (mkIf multi-scrobbler {
        virtualisation.oci-containers.containers."mutli-scrobbler" = {
          image = "foxxmd/multi-scrobbler";
          ports = ["9078:9078"];
          volumes = ["/storage/services/scrobble:/config"];
          environment = {
            PUID = "1000";
            GUID = "1000";
            TZ = "Pacific/Auckland";
          };
        };
      })
    ];
}
