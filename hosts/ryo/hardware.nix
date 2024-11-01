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
      availableKernelModules = ["nvme" "sdhci_pci" "usbhid" "xhci_pci"];
      systemd.enable = true;
      supportedFilesystems.btrfs = true;
    };
    kernelModules = ["kvm-amd"];
    kernelParams = ["iommu=soft"];
  };
  powerManagement.cpuFreqGovernor = "powersave";
  hardware = {
    cpu.amd.updateMicrocode = true;
    enableRedistributableFirmware = true;
  };
  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
    };
  };
  swapDevices = [{device = "/dev/disk/by-label/swap";}];
  # no touchy
  system.stateVersion = "24.05";
}
