{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.services.minecraft = cutelib.mkEnable;
  config = lib.mkIf config.cute.services.minecraft {
    assertions = cutelib.assertDocker "minecraft";
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
