{
  config,
  lib,
  _lib,
  ...
}: {
  options.cute.services.web.navidrome = _lib.mkWebOpt "navi" 8098;
  config = let
    inherit (config.cute.services.web.navidrome) enable port;
  in
    lib.mkIf enable {
      assertions = _lib.assertNginx;
      services.navidrome = {
        inherit enable;
        openFirewall = true;
        settings = let
          dir = "/storage/services/navidrome/";
        in {
	  Address = "0.0.0.0";
          Port = port;
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
    };
}