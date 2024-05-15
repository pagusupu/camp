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
        nh = true;
        nvim = true;
        starship = true;
        yazi = true;
        zsh.enable = true;
      };
      gui = {
        alacritty = true;
        firefox = true;
        misc = true;
        gaming = {
          gamemode = true;
          steam = true;
          games = {
            aagl = true;
            misc = true;
            osu = true;
          };
        };
      };
    };
    desktop = {
      env = {
        anyrun = true;
        waybar = true;
        misc = true;
      };
      hypr = {
        idle = true;
        lock = true;
      };
      misc = {
        audio = true;
        boot = true;
        fonts = true;
        home = true;
      };
      wm.hyprland = true;
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
    kernelModules = ["amd_pstate" "amdgpu" "kvm-amd"];
    kernelParams = [
      "amd_pstate=passive"
      "amd_pstate.shared_mem=1"
      "initcall_blacklist=acpi_cpu_freq_init"
      "video=DP-3:1920x1080@165"
      "video=HDMI-A-1:1920x1080@75"
    ];
    initrd = {
      availableKernelModules = ["ahci" "nvme" "sd_mod" "usb_storage" "usbhid" "xhci_pci"];
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
