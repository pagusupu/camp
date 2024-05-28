{
  config,
  lib,
  _lib,
  ...
}: {
  options.cute.services.media.navidrome = lib.mkEnableOption "";
  config = lib.mkIf config.cute.services.media.navidrome {
    assertions = _lib.assertNginx;
    services = {
      navidrome = {
        enable = true;
        openFirewall = true;
        settings = let
          dir = "/storage/services/navidrome/";
        in {
          Address = "0.0.0.0";
          Port = 8098;
          CacheFolder = "/var/lib/navidrome";
          DataFolder = dir + "data";
          MusicFolder = dir + "music";
          CoverJpegQuality = 100;
          IgnoredArticles = "";
          ImageCacheSize = "0";
          SessionTimeout = "96h";
          UILoginBackgroundUrl = "https://raw.githubusercontent.com/pagusupu/camp/b7b046def06e7098e76c9d498a38fc336a66e9cb/misc/images/solo.jpg";
          UIWelcomeMessage = "";
          AutoImportPlaylists = false;
          EnableExternalServices = false;
          EnableMediaFileCoverArt = false;
          EnableSharing = true;
          EnableStarRating = false;
          EnableTranscodingConfig = true;
        };
      };
      nginx.virtualHosts."navi.${config.networking.domain}" = {
        forceSSL = true;
        enableACME = true;
        locations."/" = {
          proxyPass = "http://127.0.0.1:8098";
          proxyWebsockets = true;
        };
      };
    };
  };
}
