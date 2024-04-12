{pkgs, ...}: {
  cute = {
    enabled = {
      net = {
        ip = "192.168.178.126";
        interface = "enp10s0";
      };
    };
    programs = {
      cli = {
        btop = true;
        misc = true;
        nvim = true;
        starship = true;
        yazi = true;
        zsh.enable = true;
      };
      gui = {
        alacritty = true;
        firefox = true;
        misc = true;
        waybar = true;
        wofi = true;
        games = {
          gamemode = true;
          misc = true;
          steam = true;
        };
      };
    };
    desktop = {
      audio = true;
      fonts = true;
    };
    hypr = {
      land = true;
      lock = true;
      idle = true;
      pack = true;
    };
    system = {
      boot = true;
      opengl = true;
    };
    themes.gtk = true;
  };
  time.hardwareClockInLocalTime = true; # windows dual-boot
  services = {
    dbus.enable = true;
    sshd.enable = true;
  };
  security = {
    tpm2.enable = true;
    sudo.wheelNeedsPassword = false;
  };
  networking = {
    hostName = "rin";
    hostId = "6f257938";
  };
  systemd = {
    services.systemd-udev-settle.enable = false;
    network.wait-online.enable = false;
  };
  boot = {
    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        useOSProber = true;
        device = "nodev";
        splashImage = null;
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
    };
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    kernelModules = ["amd_pstate" "kvm-amd" "amdgpu"];
    kernelParams = [
      "video=DP-3:1920x1080@165"
      "video=HDMI-A-1:1920x1080@75"
      "initcall_blacklist=acpi_cpu_freq_init"
      "amd_pstate=passive"
      "amd_pstate.shared_mem=1"
    ];
    initrd = {
      availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"];
      supportedFilesystems = ["btrfs" "ntfs"];
    };
  };
  hardware.cpu.amd.updateMicrocode = true;
  powerManagement.cpuFreqGovernor = "schedutil";
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
  # no touchy
  system.stateVersion = "23.11";
}
