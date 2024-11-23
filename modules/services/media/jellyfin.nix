{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.services.media.jellyfin = cutelib.mkEnable;
  config = lib.mkIf config.cute.services.media.jellyfin (lib.mkMerge [
    { assertions = cutelib.assertNginx "jellyfin"; }
    {
      services = {
        jellyfin = {
          enable = true;
          openFirewall = true;
        };
        nginx = cutelib.host "jlly" 8096 "true" "proxy_buffering off;";
      };
    }
    (let
      port = 5096;
    in {
      services = {
        jellyseerr = {
          enable = true;
          inherit port;
          openFirewall = true;
        };
        nginx = cutelib.host "seer" port "" "";
      };
    })
  ]);
}
