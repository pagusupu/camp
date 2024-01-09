{
  config,
  pkgs,
  lib,
  ...
}: {
  options.cute.misc.console.enable = lib.mkEnableOption "";
  config = lib.mkIf config.cute.misc.console.enable {
    console = {
      earlySetup = true;
      font = "${pkgs.terminus_font}/share/consolefonts/ter-116n.psf.gz";
      packages = with pkgs; [terminus_font];
      keyMap = "us";
      colors = let
        cute = config.cute.colours;
      in [
        "000000"
	cute.love
	cute.pine
	cute.gold
	cute.foam
	cute.iris
	cute.rose
	cute.text
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
