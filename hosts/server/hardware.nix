{
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd = {
      availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"];
    };
    kernelModules = ["kvm-amd" "amdgpu"];
    supportedFilesystems = ["btrfs"];
  };
  hardware = {
    enableRedistributableFirmware = true;
    cpu.amd.updateMicrocode = true;
  };
  networking = {
    dhcpcd.wait = "background";
    hostName = "nixserver";
  };
  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };
    "/" = {
      device = "/dev/disk/by-label/main";
      fsType = "btrfs";
    };
  };
  swapDevices = [{device = "/dev/disk/by-label/swap";}];
}
