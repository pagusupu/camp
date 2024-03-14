{
  config,
  pkgs,
  lib,
  rose-pine,
  ...
}: {
  options.cute.common.console = lib.mkEnableOption "";
  config = lib.mkIf config.cute.common.console {
    console = {
      earlySetup = true;
      font = "${pkgs.terminus_font}/share/consolefonts/ter-116n.psf.gz";
      packages = with pkgs; [terminus_font];
      keyMap = "us";
      colors = let
        inherit (rose-pine) moon;
      in [
        moon.base
        moon.love
        moon.foam
        moon.gold
        moon.pine
        moon.iris
        moon.rose
        moon.text
        moon.overlay
        moon.love
        moon.foam
        moon.gold
        moon.pine
        moon.iris
        moon.rose
        moon.text
      ];
    };
    # quiet
    boot = {
      consoleLogLevel = 0;
      initrd.verbose = false;
      kernelParams = ["quiet" "splash"];
    };
  };
}
