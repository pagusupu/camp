{
boot.loader = {
timeout = 0;
systemd-boot.enable = true;
efi.canTouchEfiVariables = true;
};
powerManagement.cpuFreqGovernor = "powersave";
hardware = {
  cpu.intel.updateMicrocode = true;
  enableRedistributableFirmware = true;
  };
boot.initrd.supportedFilesystems.btrfs = true;
  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usbhid" "sd_mod" ];
  boot.kernelModules = [ "kvm-intel"];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/a6b62079-a81d-4afb-a86d-05262259e7b4";
      fsType = "btrfs";
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/8B1C-FCC6";
      fsType = "vfat";
      options = [ "fmask=0022" "dmask=0022" ];
    };

  swapDevices =
    [ { device = "/dev/disk/by-uuid/a11616cb-0b48-4efe-a722-dd67765de44c"; }];
system.stateVersion = "23.11";
}
