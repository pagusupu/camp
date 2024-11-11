{
  boot = {
    loader = {
      timeout = 0;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd = {
      availableKernelModules = ["ahci" "nvme" "sd_mod" "xhci_pci"];
      supportedFilesystems.btrfs = true;
    };
    swraid = {
      enable = true;
      mdadmConf = "MAILADDR please@shut.up";
    };
    kernelModules = ["kvm-amd"];
  };
  powerManagement.cpuFreqGovernor = "powersave";
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
}
