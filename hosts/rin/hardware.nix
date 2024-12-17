{pkgs, ...}: {
  boot = {
    loader = {
      grub = {
        enable = true;
        configurationLimit = 5;
        device = "nodev";
        efiSupport = true;
        splashImage = null;
      };
      efi.canTouchEfiVariables = true;
    };
    initrd = {
      availableKernelModules = [ "ahci" "nvme" "sd_mod" "usb_storage" "usbhid" "xhci_pci" ];
      supportedFilesystems.btrfs = true;
    };
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    kernelModules = [ "amd_pstate" "amdgpu" "kvm-amd" ];
    kernelParams = [ "amd_pstate=guided" ];
  };
  powerManagement.cpuFreqGovernor = "schedutil";
  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };
    "/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "btrfs";
    };
    "/mnt/games" = {
      device = "/dev/nvme0n1p3";
      fsType = "btrfs";
    };
  };
  swapDevices = [ { device = "/dev/disk/by-label/swap"; } ];
}
