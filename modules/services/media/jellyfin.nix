{
  config,
  lib,
  pkgs,
  ...
}: {
  options.cute.services.media.jellyfin = lib.mkEnableOption "";
  config = let
    domain = "jelly.${config.cute.services.web.domain}";
  in
    lib.mkIf config.cute.services.media.jellyfin {
      services = {
        jellyfin = {
          enable = true;
          openFirewall = true;
        };
        nginx.virtualHosts."${domain}" = {
          forceSSL = true;
          enableACME = true;
          locations."/".proxyPass = "http://127.0.0.1:8096";
        };
      };
      # transcoding
      hardware.opengl = {
        enable = true;
        extraPackages = with pkgs; [
          vaapiVdpau
          libvdpau-va-gl
        ];
      };
    };
}
