{
  config,
  lib,
  ...
}: {
  options.cute.services.media.feishin = lib.mkEnableOption "";
  config = lib.mkIf config.cute.services.media.feishin {
    virtualisation = {
      oci-containers = {
        backend = "docker";
        containers."feishin" = {
          ports = ["9180:9180"];
          image = "ghcr.io/jeffvli/feishin:latest";
        };
      };
      docker = {
        enable = true;
        storageDriver = "btrfs";
      };
    };
  };
}
