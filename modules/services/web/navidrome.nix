{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}: {
  options.cute.services.web.navidrome = cutelib.mkWebOpt "navi" 8098;
  config = let
    inherit (config.cute.services.web.navidrome) enable port;
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
          EnableExternalServices = false;
          EnableMediaFileCoverArt = false;
          EnableSharing = true;
          EnableStarRating = false;
          EnableTranscodingConfig = true;
          IgnoredArticles = "";
          SessionTimeout = "96h";
          UIWelcomeMessage = "";
        };
      };
      environment.systemPackages = [pkgs.flac pkgs.sox];
    };
}
