{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}: {
  options.cute.services.web = {
    jellyfin = cutelib.mkWebOpt "jlly" 8096;
    jellyseerr = cutelib.mkWebOpt "seer" 5096;
  };
  config = let
    inherit (config.cute.services.web) jellyfin jellyseerr;
  in
    lib.mkMerge [
      (lib.mkIf jellyfin.enable {
        assertions = cutelib.assertNginx "jellyfin";
        services.jellyfin = {
          enable = true;
          openFirewall = true;
        };
        hardware.graphics.extraPackages = with pkgs; [
          libvdpau-va-gl
          vaapiVdpau
        ];
        cute.services = {
          web.jellyfin = {
            extraSettings = {
              enable = true;
              text = "proxy_buffering off;";
            };
            websocket = true;
          };
          servers.nginx.hosts = ["jellyfin"];
        };
      })
      (let
        inherit (jellyseerr) enable port;
      in
        lib.mkIf enable {
          assertions = cutelib.assertNginx "jellyseer";
          services.jellyseerr = {
            inherit enable port;
            openFirewall = true;
          };
          cute.services.servers.nginx.hosts = ["jellyseerr"];
        })
      (lib.mkIf jellyseerr.enable {
        assertions = [
          {
            assertion = config.cute.services.web.jellyfin.enable;
            message = "jellyseer requires jellyfin service.";
          }
        ];
      })
    ];
}
