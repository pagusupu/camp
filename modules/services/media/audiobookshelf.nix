{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.services.web.audiobookshelf = cutelib.mkWebOpt "shlf" 8095;
  config = let
    inherit (config.cute.services.web.audiobookshelf) enable port;
  in
    lib.mkIf enable {
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
    };
}
