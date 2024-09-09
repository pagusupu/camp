{
  config,
  lib,
  cutelib,
  ...
}: let
  inherit (lib) mkOption types mkIf mkMerge mkDefault;
in {
  options.cute.services.minecraft = {
    enable = cutelib.mkEnable;
    server = mkOption {
      default = null;
      type = types.enum ["vanilla" "modded"];
    };
  };
  config = let
    inherit (config.cute.services.minecraft) enable server;
  in
    mkIf enable {
      assertions = cutelib.assertDocker "minecraft";
      virtualisation.oci-containers.containers."minecraft" = mkMerge [
        {
          image = "itzg/minecraft-server:stable";
          ports = ["25565:25565"];
          environment = {
            EULA = "true";
            MEMORY = "8G";
            SERVER_NAME = mkDefault "${server}";
            MOTD = mkDefault ":3";
            DIFFICULTY = mkDefault "normal";
          };
          volumes = ["/storage/services/minecraft/${server}:/data"];
        }
        (mkIf (server == "vanilla") {
          environment = {
            VERSION = "1.21.1";
            LEVEL = "world"; # list: world
          };
        })
        (mkIf (server == "modded") {
          environment = {
            SERVER_NAME = "";
            VERSION = "1.21.1";
            TYPE = "FABRIC";
            #MODPACK = "";
          };
        })
      ];
      networking.firewall.allowedUDPPorts = mkIf (server == "modded") [24454]; # vc mod
    };
}
