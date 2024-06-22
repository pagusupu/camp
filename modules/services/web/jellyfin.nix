{
  config,
  lib,
  _lib,
  pkgs,
  ...
}: {
  options.cute.services.web.jellyfin = _lib.mkWebOpt "jlly" 8096;
  config = let
    inherit (config.cute.services.web.jellyfin) enable;
  in
    lib.mkIf enable {
      assertions = _lib.assertNginx;
      services.jellyfin = {
        inherit enable;
        openFirewall = true;
      };
      hardware.graphics.extraPackages = [
        pkgs.libvdpau-va-gl
        pkgs.vaapiVdpau
      ];
    };
}
