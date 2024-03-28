{
  config,
  lib,
  pkgs,
  ...
}: {
  options.cute.common.system = {
    plymouth = lib.mkEnableOption "";
    hardware = {
      enable = lib.mkEnableOption "";
      amd = lib.mkEnableOption "";
      intel = lib.mkEnableOption "";
    };
  };
  config = let
    inherit (config.cute.common.system) plymouth;
    inherit (config.cute.common.system.hardware) enable amd intel;
  in
    lib.mkIf enable {
      hardware = {
        enableRedistributableFirmware = true;
        cpu = {
          amd.updateMicrocode = lib.mkIf amd true;
          intel.updateMicrocode = lib.mkIf intel true;
        };
        opengl = {
          enable = true;
          extraPackages = with pkgs;
            lib.mkIf amd [
              vaapiVdpau
              libvdpau-va-gl
            ];
        };
      };
      boot.plymouth = lib.mkIf plymouth {
        enable = true;
        font = "${pkgs.nerdfonts}/share/fonts/opentype/NerdFonts/MonaspiceNeNerdFont-Regular.otf";
      };
      console.font = "${pkgs.terminus_font}/share/consolefonts/ter-116n.psf.gz";
      time.timeZone = "NZ";
      i18n.defaultLocale = "en_NZ.UTF-8";
    };
}
