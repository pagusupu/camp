{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.services.backend.docker = cutelib.mkEnable;
  config = lib.mkIf config.cute.services.backend.docker {
    virtualisation = {
      docker = {
        enable = true;
        storageDriver = "btrfs";
      };
      oci-containers.backend = "docker";
    };
  };
}
