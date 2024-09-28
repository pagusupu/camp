{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}: let
  inherit (cutelib) mkWebOpt assertNginx;
  inherit (lib) mkMerge mkIf;
in {
  options.cute.services.web = {
    jellyfin = mkWebOpt "jlly" 8096;
    jellyseerr = mkWebOpt "seer" 5096;
    komga = mkWebOpt "kmga" 8097;
  };
  config = let
    inherit (config.cute.services.web) jellyfin jellyseerr komga;
  in
    mkMerge [
      (let
        inherit (jellyfin) enable;
      in
        mkIf enable {
          assertions = assertNginx "jellyfin";
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
        mkIf enable (mkMerge [
          {
            assertions = assertNginx "jellyseer";
            services.jellyseerr = {
              inherit enable port;
              openFirewall = true;
            };
            cute.services.servers.nginx.hosts = ["jellyseerr"];
          }
          {
            assertions = [
              {
                assertion = config.cute.services.web.jellyfin.enable;
                message = "jellyseer requires jellyfin service.";
              }
            ];
          }
        ]))
      (let
        inherit (komga) enable port;
      in
        mkIf enable {
          assertions = assertNginx "komga";
          services.komga = {
            inherit enable port;
            openFirewall = true;
          };
          cute.services.servers.nginx.hosts = ["komga"];
        })
    ];
}
