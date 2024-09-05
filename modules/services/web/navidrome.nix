{
  config,
  lib,
  _lib,
  pkgs,
  ...
}: {
  options.cute.services.web.navidrome = _lib.mkWebOpt "navi" 8098;
  config = let
    inherit (config.cute.services.web.navidrome) enable port;
  in
    lib.mkIf enable {
      assertions = _lib.assertNginx "navidrome";
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
          EnableExternalServices = false;
          EnableMediaFileCoverArt = false;
          EnableSharing = true;
          EnableStarRating = false;
          EnableTranscodingConfig = true;
          IgnoredArticles = "";
          SessionTimeout = "96h";
          UILoginBackgroundUrl = "https://raw.githubusercontent.com/pagusupu/camp/main/modules/themes/rose-pine/wallpapers/light-left.png";
          UIWelcomeMessage = "";
        };
      };
      environment.systemPackages = [pkgs.flac pkgs.sox];
    };
}
