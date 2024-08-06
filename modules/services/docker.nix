{
  config,
  lib,
  _lib,
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
    mkIf enable (mkMerge [
      (mkIf feishin {
        assertions = _lib.assertDocker "feishin";
        virtualisation.oci-containers.containers."feishin" = {
          image = "ghcr.io/jeffvli/feishin:0.7.1";
          ports = ["9180:9180"];
        };
      })
      {
        virtualisation = {
          docker = {
            enable = true;
            storageDriver = "btrfs";
          };
          oci-containers.backend = "docker";
        };
      }
    ]);
}
