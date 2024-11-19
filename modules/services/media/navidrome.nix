{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}: {
  options.cute.services.media.navidrome = cutelib.mkEnable;
  config = lib.mkIf config.cute.services.media.navidrome (let
    inherit (builtins) toString;
    inherit (cutelib) assertDocker assertNginx host;
    inherit (lib) mkMerge;
  in
    mkMerge [
      (let
        port = 9180;
      in {
        assertions = assertDocker "feishin";
        virtualisation.oci-containers.containers."feishin" = {
          image = "ghcr.io/jeffvli/feishin:0.11.1";
          ports = ["${toString port}:9180"];
        };
        services.nginx = host "fish" port "" "";
      })
      (let
        port = 9078;
      in {
        assertions = assertDocker "multi-scrobbler";
        virtualisation.oci-containers.containers."multi-scrobbler" = {
          image = "foxxmd/multi-scrobbler";
          ports = ["${toString port}:9078"];
          environment = {
            BASE_URL = "http://${config.cute.net.ip}:${toString port}";
            TZ = "NZ";
          };
          volumes = ["/storage/multi-scrobbler:/config"];
        };
      })
      (let
        port = 8098;
      in {
        assertions = assertNginx "navidrome";
        services = {
          navidrome = {
            enable = true;
            openFirewall = true;
            settings = mkMerge [
              (let
                p = "/storage/navidrome/";
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
          nginx = host "navi" port "true" "";
        };
        environment.systemPackages = with pkgs; [
          flac
          streamrip
          sox
        ];
      })
    ]);
}
