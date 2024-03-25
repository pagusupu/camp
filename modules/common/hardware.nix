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
        # quiet
        initrd.verbose = false;
        consoleLogLevel = 0;
        kernelParams = ["quiet" "splash"];
      };
      console = lib.mkIf boot {
        earlySetup = true;
        font = "${pkgs.terminus_font}/share/consolefonts/ter-116n.psf.gz";
      };
      networking = {
        firewall.enable = true;
        enableIPv6 = false;
        useDHCP = false;
      };
      time.timeZone = "NZ";
      i18n.defaultLocale = "en_NZ.UTF-8";
    };
}
