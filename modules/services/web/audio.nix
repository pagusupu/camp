{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}: let
  inherit (cutelib) mkWebOpt;
  inherit (lib) mkIf mkMerge;
in {
  options.cute.services.web = {
    audiobookshelf = mkWebOpt "shlf" 8095;
    feishin = mkWebOpt "fish" 9180;
    navidrome = mkWebOpt "navi" 8098;
  };
  config = let
    inherit (config.cute.services.web) audiobookshelf feishin navidrome;
  in
    mkMerge [
      (let
        inherit (audiobookshelf) enable port;
      in
        mkIf enable {
          assertions = cutelib.assertNginx "audiobookshelf";
          services.audiobookshelf = {
            inherit enable port;
            openFirewall = true;
            host = "0.0.0.0";
          };
          cute.services = {
            servers.nginx.hosts = ["audiobookshelf"];
            web.audiobookshelf.websocket = true;
          };
        })
      (let
        inherit (feishin) enable port;
      in
        mkIf enable (mkMerge [
          {assertions = cutelib.assertNginx "feishin";}
          {
            assertions = cutelib.assertDocker "feishin";
            virtualisation.oci-containers.containers."feishin" = {
              image = "ghcr.io/jeffvli/feishin:0.9.0";
              ports = ["${builtins.toString port}:9180"];
            };
            cute.services.servers.nginx.hosts = ["feishin"];
          }
        ]))
      (let
        inherit (navidrome) enable port dns;
      in
        mkIf enable {
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
              Prometheus.Enabled = true;
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
        })
    ];
}
