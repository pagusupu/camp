{
  config,
  lib,
  pkgs,
  colours,
  ...
}: {
  options.cute.system = {
    boot = lib.mkEnableOption "";
    opengl = lib.mkEnableOption "";
  };
  config = let
    inherit (lib) mkMerge mkIf;
    inherit (config.cute.system) boot opengl;
  in
    mkMerge [
      (mkIf boot {
        boot = {
          enableContainers = false;
          initrd.verbose = false;
          kernelParams = ["quiet" "splash"];
        };
        console = {
          font = "${pkgs.terminus_font}/share/consolefonts/ter-116n.psf.gz";
          colors = let
            inherit (colours) dark;
          in [
            "000000"
            dark.love
            dark.foam
            dark.gold
            dark.pine
            dark.iris
            dark.rose
            dark.text
            dark.overlay
            dark.love
            dark.foam
            dark.gold
            dark.pine
            dark.iris
            dark.rose
            dark.text
          ];
        };
      })
      (mkIf opengl {
        hardware.opengl = {
          enable = true;
          extraPackages = with pkgs; [
            vaapiVdpau
            libvdpau-va-gl
          ];
        };
      })
    ];
}
