{
  config,
  lib,
  cutelib,
  ...
}: let
  inherit (lib) mkMerge mkIf;
in {
  options.cute.services = {
    docker = cutelib.mkEnable;
    feishin = cutelib.mkEnable;
  };
  config = let
    inherit (config.cute.services) docker feishin;
  in
    mkMerge [
      (mkIf docker {
        virtualisation = {
          docker = {
            enable = true;
            storageDriver = "btrfs";
          };
          oci-containers.backend = "docker";
        };
      })
      (mkIf feishin {
        assertions = cutelib.assertDocker "feishin";
        virtualisation.oci-containers.containers."feishin" = {
          image = "ghcr.io/jeffvli/feishin:0.7.3";
          ports = ["9180:9180"];
        };
      })
    ];
}
