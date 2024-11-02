{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}: {
  options.cute.services.media.navidrome = cutelib.mkEnable;
  config = lib.mkIf config.cute.services.media.navidrome (lib.mkMerge [
    (let
      port = 9180;
    in {
      assertions = cutelib.assertDocker "feishin";
      virtualisation.oci-containers.containers."feishin" = {
        image = "ghcr.io/jeffvli/feishin:0.11.1";
        ports = ["${builtins.toString port}:9180"];
      };
      services.nginx = cutelib.host "fish" port "" "";
    })
    (let
      port = 8098;
    in {
      assertions = cutelib.assertNginx "navidrome";
      services = {
        navidrome = {
          enable = true;
          openFirewall = true;
          settings = lib.mkMerge [
            (let
              p = "/storage/services/navidrome/";
            in {
              Address = "0.0.0.0";
              Port = port;
              CacheFolder = "/var/lib/navidrome";
              DataFolder = p + "data";
              MusicFolder = p + "music";
            })
            {
              AutoImportPlaylists = false;
              DefaultTheme = "Auto";
              EnableExternalServices = false;
              EnableMediaFileCoverArt = false;
              EnableSharing = true;
              EnableStarRating = false;
              IgnoredArticles = "";
              SessionTimeout = "96h";
              ShareURL = "https://navi.${config.networking.domain}";
              UIWelcomeMessage = "";
            }
          ];
        };
        nginx = cutelib.host "navi" port "true" "";
      };
      environment.systemPackages = with pkgs; [
        flac
        streamrip
        sox
      ];
    })
  ]);
}
