{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}: {
  options.cute.services.web.jellyfin = cutelib.mkWebOpt "jlly" 8096;
  config = let
    inherit (config.cute.services.web.jellyfin) enable;
  in
    lib.mkIf enable {
      assertions = cutelib.assertNginx "jellyfin";
      services = {
        jellyfin = {
          inherit enable;
          openFirewall = true;
        };
      };
      hardware.graphics.extraPackages = with pkgs; [
        libvdpau-va-gl
        vaapiVdpau
      ];
    };
}
