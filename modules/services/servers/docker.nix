{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.services.servers.docker = cutelib.mkEnable;
  config = lib.mkIf config.cute.services.servers.docker {
    virtualisation = {
      docker = {
        enable = true;
        storageDriver = "btrfs";
      };
      oci-containers.backend = "docker";
    };
  };
}
