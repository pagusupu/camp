{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.services.media.jellyfin = cutelib.mkEnable;
  config = lib.mkIf config.cute.services.media.jellyfin {
    assertions = cutelib.assertNginx "jellyfin";
    services = {
      jellyfin = {
        enable = true;
        openFirewall = true;
      };
      jellyseerr = {
        enable = true;
        port = 5096;
        openFirewall = true;
      };
      nginx.virtualHosts = let
        enableACME = true;
        forceSSL = true;
      in {
        "jlly.pagu.cafe" = {
          locations."/" = {
            proxyPass = "http://localhost:8096";
            proxyWebsockets = true;
            extraConfig = "proxy_buffering off;";
          };
          inherit enableACME forceSSL;
        };
        "seer.pagu.cafe" = {
          locations."/".proxyPass = "http://localhost:5096";
          inherit enableACME forceSSL;
        };
      };
    };
  };
}
