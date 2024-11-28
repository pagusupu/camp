{
  boot = {
    loader = {
      timeout = 0;
      systemd-boot = {
        enable = true;
        configurationLimit = 5;
      };
      efi.canTouchEfiVariables = true;
    };
    initrd = {
      availableKernelModules = [ "nvme" "sdhci_pci" "usbhid" "xhci_pci" ];
      supportedFilesystems.btrfs = true;
    };
    kernelModules = [ "kvm-amd" ];
    kernelParams = [ "iommu=soft" ];
  };
  powerManagement.cpuFreqGovernor = "powersave";
  services.fprintd.enable = true;
  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
    };
  };
  swapDevices = [ { device = "/dev/disk/by-label/swap"; } ];
}
