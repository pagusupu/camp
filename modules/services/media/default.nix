{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkMerge mkIf;
in {
  options.cute.services.media = {
    jellyfin = mkEnableOption "";
    komga = mkEnableOption "";
  };
  config = let
    inherit (config.cute.services.media) jellyfin komga;
    inherit (config.networking) domain;
    common = {
      forceSSL = true;
      enableACME = true;
    };
  in
    mkMerge [
      (mkIf jellyfin {
        services = {
          jellyfin = {
            enable = true;
            openFirewall = true;
          };
          nginx.virtualHosts."jlly.${domain}" = {locations."/".proxyPass = "http://127.0.0.1:8096";} // common;
        };
      })
      (mkIf komga {
        services = {
          komga = {
            enable = true;
            openFirewall = true;
            port = 8097;
          };
          nginx.virtualHosts."kmga.${domain}" = {locations."/".proxyPass = "http://127.0.0.1:8097";} // common;
        };
      })
    ];
}
