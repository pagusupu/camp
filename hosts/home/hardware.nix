{pkgs, ...}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    loader = {
      grub = {
        enable = true;
        useOSProber = true;
        efiSupport = true;
        device = "nodev";
      };
      efi.canTouchEfiVariables = true;
    };
    initrd = {
      kernelModules = ["amdgpu"];
      availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"];
    };
    kernelParams = [
      "video=HDMI-A-1:1920x1080@75"
      "video=DP-3:1920x1080@165"
      "amd_pstate=passive"
      "amd_pstate.shared_mem=1"
    ];
    kernelModules = ["kvm-amd" "amd_pstate"];
    supportedFilesystems = ["btrfs" "ntfs"];
  };
  hardware = {
    enableRedistributableFirmware = true;
    cpu.amd.updateMicrocode = true;
    pulseaudio.enable = false;
    bluetooth.enable = true;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };
  powerManagement.cpuFreqGovernor = "schedutil";
  security.tpm2.enable = true;
  networking = {
    hostName = "home";
  };
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/9dd5237a-fab2-474d-9f0d-84f326ccefc9";
    fsType = "btrfs";
  };
  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/F566-9676";
    fsType = "vfat";
  };
  swapDevices = [
    {device = "/dev/disk/by-uuid/b505fb66-8b84-44ff-9d1f-789627d70fe7";}
  ];
}
