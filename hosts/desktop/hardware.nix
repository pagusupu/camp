{pkgs, ...}: {
  boot = {
    consoleLogLevel = 0;
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    loader = {
      timeout = 2;
      grub = {
        enable = true;
        efiSupport = true;
	device = "nodev";
	useOSProber = true;
	splashImage = null;
      };
      efi.canTouchEfiVariables = true;
    };
    initrd = {
      verbose = false;
      kernelModules = ["amdgpu"];
      availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"];
    };
    kernelParams = [
      "initcall_blacklist=acpi_cpufreq_init"
      "amd_pstate=passive"
      "amd_pstate.shared_mem=1"
      "quiet"
      "splash"
    ];
    kernelModules = ["kvm-amd" "amd_pstate"];
    supportedFilesystems = ["btrfs" "ntfs"];
  };
  powerManagement.cpuFreqGovernor = "schedutil";
  hardware = {
    bluetooth.enable = true;
    cpu.amd.updateMicrocode = true;
    enableRedistributableFirmware = true;
    pulseaudio.enable = false;
    xone.enable = true;
    opengl = {
      enable = true;
      driSupport = true;
      driSupport32Bit = true;
    };
  };
  networking = {
    dhcpcd.wait = "background";
    hostName = "desktop";
    wireless = {
      enable = true;
      userControlled.enable = true;
    };
  };
  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-label/NixBoot";
      fsType = "vfat";
    };
    "/" = {
      device = "/dev/disk/by-label/Flake";
      fsType = "btrfs";
    };
    "/mnt/games" = {
      device = "/dev/disk/by-label/Games";
      fsType = "btrfs";
    };
  };
  swapDevices = [{device = "/dev/disk/by-label/SwapFile";}];
}
