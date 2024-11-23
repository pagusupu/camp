{
  boot = {
    loader = {
      timeout = 0;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd = {
      supportedFilesystems.btrfs = true;
      availableKernelModules = [ "ahci" "ehci_pci" "sd_mod" "usbhid" "xhci_pci" ];
    };
    kernelModules = [ "kvm-intel" ];
  };
  powerManagement.cpuFreqGovernor = "powersave";
  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
    };
  };
  swapDevices = [ { device = "/dev/disk/by-label/swap"; } ];
}
