{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}: {
  options.cute.services.media.navidrome = cutelib.mkEnable;
  config = lib.mkIf config.cute.services.media.navidrome {
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
            Port = 8098;
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
            ShareURL = "https://navi.pagu.cafe";
            UIWelcomeMessage = "";
          }
        ];
      };
      nginx.virtualHosts."navi.pagu.cafe" = {
        locations."/" = {
          proxyPass = "http://localhost:8098";
          proxyWebsockets = true;
        };
        enableACME = true;
        forceSSL = true;
      };
    };
    environment.systemPackages = with pkgs; [
      flac
      streamrip
      sox
    ];
  };
}
