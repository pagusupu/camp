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
      environment.systemPackages = with pkgs; [
        id3v2
        yt-dlp
      ];
      hardware.graphics.extraPackages = with pkgs; [
        libvdpau-va-gl
        vaapiVdpau
      ];
    };
}
