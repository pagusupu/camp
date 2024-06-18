{pkgs, ...}: {
  cute = {
    desktop = {
      anyrun = true;
      swaync = true;
      waybar = true;
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
      wm = {
        hyprland = true;
        niri = true;
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
        zsh = true;
      };
      gui = {
        aagl = true;
        alacritty = true;
        firefox = true;
        gamemode = true;
        misc = true;
        steam = true;
      };
    };
    net = {
      ip = "192.168.178.126";
      interface = "enp10s0";
    };
    theme = {
      gtk = true;
      name = "rose-pine";
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
  services = {
    dbus.enable = true;
    sshd.enable = true;
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
    kernelParams = ["amd_pstate=guided"];
    initrd = {
      availableKernelModules = ["ahci" "nvme" "sd_mod" "usb_storage" "usbhid" "xhci_pci"];
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
