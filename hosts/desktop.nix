{pkgs, ...}: {
  cute = {
    desktop = {
      alacritty = true;
      audio = true;
      firefox = true;
      fonts = true;
      programs = true;
      xdg = true;
      games = {
        gamemode = true;
        misc = true;
        steam = true;
      };
    };
    home = {
      enable = true;
      ags = false;
      base16 = true;
      gtk = true;
      hyprland = true;
      mako = true;
      waybar = true;
      wofi = true;
    };
    common = {
      git = true;
      nixvim = true;
      ssh = false;
      tools = true;
      zsh = {
        enable = true;
        starship = true;
      };
      system = {
        nix = true;
        #plymouth = true;
        user = true;
        hardware = {
          enable = true;
          amd = true;
        };
        networking = {
          enable = true;
          wired = {
            enable = true;
            ip = "192.168.178.126";
            interface = "enp10s0";
          };
        };
      };
    };
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
    hostName = "desktop";
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
      "quiet"
      "splash"
    ];
    initrd = {
      availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"];
      supportedFilesystems = ["btrfs ntfs"];
      # quiet
      verbose = false;
    };
    consoleLogLevel = 0;
  };
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
