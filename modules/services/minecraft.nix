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

        DIFFICULTY = "normal";
        ICON = "https://next.pagu.cafe/s/KqdoTDgm3Xjs8cg/download/20230323_135441.jpg";
        MOTD = ":3";
        SERVER_NAME = "hehehehehehe";
      };
      volumes = ["/storage/services/minecraft/vanilla:/data"];
    };
  };
}
