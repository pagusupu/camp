{
  config,
  pkgs,
  lib,
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
        inherit (config.cute) colours;
      in [
        colours.base
        colours.love
        colours.foam
        colours.gold
        colours.pine
        colours.iris
        colours.rose
        colours.text
        colours.overlay
        colours.love
        colours.foam
        colours.gold
        colours.pine
        colours.iris
        colours.rose
        colours.text
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
