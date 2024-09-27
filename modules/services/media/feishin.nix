{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.services.feishin = cutelib.mkEnable;
  config = lib.mkIf config.cute.services.feishin {
    assertions = cutelib.assertDocker "feishin";
    virtualisation.oci-containers.containers."feishin" = {
      image = "ghcr.io/jeffvli/feishin:0.9.0";
      ports = ["9180:9180"];
    };
  };
}
