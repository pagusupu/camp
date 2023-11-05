{
  config,
  pkgs,
  lib,
  ...
}: {
  options.cute.misc.console = {
    enable = lib.mkEnableOption "console theme";
  };
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
        cute.normal.red
        cute.normal.green
        cute.normal.yellow
        cute.normal.blue
        cute.normal.magenta
        cute.normal.cyan
        cute.normal.white
        cute.bright.red
        cute.bright.green
        cute.bright.yellow
        cute.bright.blue
        cute.bright.magenta
        cute.bright.cyan
        cute.bright.white
        cute.primary.fg
      ];
    };
  };
}
