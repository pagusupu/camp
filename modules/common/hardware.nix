{
  config,
  lib,
  pkgs,
  ...
}: {
  options.cute.common.system.hardware = {
    enable = lib.mkEnableOption "";
    boot = lib.mkEnableOption "";
    amd = lib.mkEnableOption "";
    intel = lib.mkEnableOption "";
  };
  config = let
    inherit (config.cute.common.system.hardware) enable boot amd intel;
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
      boot = lib.mkIf boot {
        loader.efi.canTouchEfiVariables = true;
        plymouth = {
          enable = true;
          font = "${pkgs.nerdfonts}/share/fonts/opentype/NerdFonts/MonaspiceNeNerdFont-Regular.otf";
        };
      };
      time.timeZone = "NZ";
      i18n.defaultLocale = "en_NZ.UTF-8";
    };
}
