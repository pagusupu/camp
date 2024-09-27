{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}: {
  options.cute.services.web.navidrome = cutelib.mkWebOpt "navi" 8098;
  config = let
    inherit (config.cute.services.web.navidrome) enable port dns;
  in
    lib.mkIf enable {
      assertions = cutelib.assertNginx "navidrome";
      services.navidrome = {
        inherit enable;
        openFirewall = true;
        settings = let
          p = "/storage/services/navidrome/";
        in {
          Address = "0.0.0.0";
          Port = port;
          CacheFolder = "/var/lib/navidrome";
          DataFolder = p + "data";
          MusicFolder = p + "music";
          AutoImportPlaylists = false;
          DefaultTheme = "Auto";
          EnableExternalServices = false;
          EnableMediaFileCoverArt = false;
          EnableSharing = true;
          EnableStarRating = false;
          IgnoredArticles = "";
          SessionTimeout = "96h";
          ShareURL = "https://${dns}.${config.networking.domain}";
          UIWelcomeMessage = "";
        };
      };
      environment.systemPackages = with pkgs; [
        flac
        streamrip
        sox
      ];
      cute.services = {
        servers.nginx.hosts = ["navidrome"];
        web.navidrome.websocket = true;
      };
    };
}
