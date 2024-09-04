{pkgs, ...}: {
  cute = {
    desktop = {
      hypr = {
        idle = true;
        land = true;
        lock = true;
        paper = false; # build failure
      };
      misc = {
        audio = true;
        fonts = true;
        home = true;
      };
      mako = true;
      tofi = true;
      waybar = true;
    };
    programs = {
      cli = {
        btop = true;
        misc = true;
        nh = true;
        nvim = true;
        starship = true;
        yazi = true;
        zsh = true;
      };
      gui = {
        aagl = true;
        alacritty = true;
        firefox = true;
        misc = true;
        prismlauncher = true;
        steam = true;
      };
    };
    net = {
      ip = "192.168.178.126";
      name = "enp10s0";
    };
    theme = {
      gtk = true;
      name = "everforest";
    };
  };
  time.hardwareClockInLocalTime = true; # windows dual-boot
  networking = {
    hostName = "rin";
    hostId = "6f257938";
  };
  security = {
    tpm2.enable = true;
    sudo.wheelNeedsPassword = false;
  };
  systemd = {
    services.systemd-udev-settle.enable = false;
    network.wait-online.enable = false;
  };
  boot = {
    loader = {
      grub = {
        enable = true;
        configurationLimit = 10;
        device = "nodev";
        efiSupport = true;
        splashImage = null;
        useOSProber = true;
      };
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    kernelModules = ["amd_pstate" "amdgpu" "kvm-amd"];
    kernelParams = ["amd_pstate=guided"];
    initrd = {
      availableKernelModules = [
        "ahci"
        "nvme"
        "sd_mod"
        "usb_storage"
        "usbhid"
        "xhci_pci"
      ];
      systemd.enable = true;
      supportedFilesystems.btrfs = true;
    };
    supportedFilesystems.ntfs = true;
  };
  hardware.cpu.amd.updateMicrocode = true;
  powerManagement.cpuFreqGovernor = "schedutil";
  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-label/NixBoot";
      fsType = "vfat";
      options = ["fmask=0022" "dmask=0022"];
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
  # no touchy
  system.stateVersion = "23.11";
}
