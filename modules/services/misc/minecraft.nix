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
          volumes = ["/home/pagu/minecraft/${server}:/data"];
          environment = {
            EULA = "true";
            MOTD = ":3";
            DIFFICULTY = mkDefault "hard";
            ICON = "https://pagu.cafe/paguicon.jpg";
            VIEW_DISTANCE = "12";
            SIMULATION_DISTANCE = "6";
            INIT_MEMORY = "8G";
            MAX_MEMORY = "12G";
            SERVER_PORT = "25565";
            ENABLE_WHITELIST = "true";
            ENABLE_AUTOPAUSE = "true";
            MAX_TICK_TIME = "-1";
          };
          autoStart = false;
        }
        (mkIf (server == "vanilla") {
          environment = {
            VERSION = "1.21.1";
            LEVEL = "world"; # list: world
          };
        })
        (mkIf (server == "modded") {
          environment = {
            VERSION = "1.21.1";
            TYPE = "MODRINTH";
            MODRINTH_MODPACK = "https://pagu.cafe/pagupack.mrpack";
            RCON_COMMANDS_STARTUP = "/gamerule playersSleepingPercentage 20";
          };
          ports = ["24454:24454/udp"]; # vc mod
        })
      ];
    };
}
