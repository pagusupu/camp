{
  config,
  lib,
  pkgs,
  ...
}: {
  options.cute.services.media.navidrome = lib.mkEnableOption "";
  config = let
    domain = "navi.${config.cute.services.web.domain}";
  in
    lib.mkIf config.cute.services.media.navidrome {
      age.secrets.navi-fm.file = ../../../secrets/navi-fm.age;
      services = {
        navidrome = {
          enable = true;
          openFirewall = true;
          settings = {
            Address = "0.0.0.0";
            Port = 8098;
            DataFolder = "/var/lib/navidrome";
            MusicFolder = "/storage/services/navidrome/music";
            ArtistArtPriority = "artist.*, album/artist.*";
            AutoImportPlaylists = false;
            EnableSharing = true;
            EnableStarRating = false;
            EnableTranscodingConfig = true;
            UIWelcomeMessage = "";
            LastFM = {
              ApiKey = "9bb677319d28788826b28537483ab363";
              Secret = config.age.secrets.navi-fm.path;
            };
          };
        };
        nginx.virtualHosts."${domain}" = {
          forceSSL = true;
          enableACME = true;
          locations."/".proxyPass = "http://127.0.0.1:8098";
        };
      };
      environment.systemPackages = [pkgs.flac];
    };
}
