{
  config,
  lib,
  pkgs,
  ...
}: {
  options.cute.common.system.boot = lib.mkEnableOption "";
  config = lib.mkIf config.cute.common.system.boot {
    boot = {
      loader.efi.canTouchEfiVariables = true;
      initrd = {
        supportedFilesystems = ["btrfs"];
        availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"];
        # quiet
        verbose = false;
      };
      consoleLogLevel = 0;
      kernelParams = ["quiet" "splash"];
    };
    console = {
      earlySetup = true;
      font = "${pkgs.terminus_font}/share/consolefonts/ter-116n.psf.gz";
      #packages = with pkgs; [terminus_font];
      keyMap = "us";
    };
  };
}
