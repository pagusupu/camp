{
  boot = {
    loader = {
      timeout = 0;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelModules = ["kvm-amd"];
    initrd = {
      availableKernelModules = ["ahci" "nvme" "sd_mod" "xhci_pci"];
      supportedFilesystems.btrfs = true;
    };
    swraid.enable = true;
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
      options = ["fmask=0022" "dmask=0022"];
    };
    "/" = {
      device = "/dev/disk/by-label/main";
      fsType = "btrfs";
    };
    "/storage" = {
      device = "/dev/disk/by-label/storage";
      fsType = "btrfs";
    };
  };
  swapDevices = [{device = "/dev/disk/by-label/swap";}];
  # no touchy
  system.stateVersion = "23.11";
}
