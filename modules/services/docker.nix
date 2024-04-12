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
  };
  config = let
    inherit (config.cute.services.docker) enable feishin;
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
        virtualisation.oci-containers.containers = {
          "feishin" = {
            image = "ghcr.io/jeffvli/feishin:latest";
            ports = ["9180:9180"];
          };
        };
        services.nginx.virtualHosts."fish.${config.networking.domain}" = {
          forceSSL = true;
          enableACME = true;
          locations."/".proxyPass = "http://127.0.0.1:9180";
        };
      })
    ];
}
