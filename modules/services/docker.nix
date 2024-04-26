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
    memos = mkEnableOption "";
  };
  config = let
    inherit (config.networking) domain;
    inherit (config.cute.services.docker) enable feishin memos;
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
          image = "ghcr.io/jeffvli/feishin:latest";
          ports = ["9180:9180"];
        };
        services.nginx.virtualHosts."fish.${domain}" = {locations."/".proxyPass = "http://127.0.0.1:9180";} // common;
      })
      (mkIf memos {
        virtualisation.oci-containers.containers."memos" = {
          image = "neosmemo/memos:stable";
          ports = ["5230:5230"];
          volumes = ["/storage/services/memos/:/var/opt/memos"];
        };
        services.nginx.virtualHosts."memo.${domain}" = {locations."/".proxyPass = "http://127.0.0.1:5230";} // common;
      })
    ];
}
