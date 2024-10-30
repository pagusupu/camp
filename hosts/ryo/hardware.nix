{
  boot = {
    loader = {
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
  powerManagement.cpuFreqGoverner = "powersave";
  hardware = {
    cpu.amd.updateMicrocode = true;
    enableRedistributableFirmware = true;
  };
  filesystems = {
    "/efi" = {
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
  system.stateVersion = "24.05";
}
