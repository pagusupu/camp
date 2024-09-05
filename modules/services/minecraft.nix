{
  config,
  lib,
  _lib,
  ...
}: {
  options.cute.services.minecraft = _lib.mkEnable;
  config = lib.mkIf config.cute.services.minecraft {
    assertions = _lib.assertDocker "minecraft";
    virtualisation.oci-containers.containers."minecraft" = {
      image = "itzg/minecraft-server:stable";
      ports = ["25565:25565"];
      environment = {
        EULA = "true";
        MEMORY = "8G";
        VERSION = "1.21.1";
      };
      volumes = ["/storage/services/minecraft/vanilla:/data"];
    };
  };
}
