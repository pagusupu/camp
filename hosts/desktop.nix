{pkgs, ...}: {
  cute = {
    desktop = {
      alacritty = true;
      audio = true;
      firefox = true;
      fonts = true;
      greetd = true;
      gtk = true;
      misc = true;
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
      hyprland = true;
      mako = true;
      wofi = true;
      themes = {
        discord = true;
        firefox = true;
        woficss = true;
      };
    };
    common = {
      console = true;
      git = true;
      nixvim = true;
      tools = true;
      zsh = {
        enable = true;
        prompt = "'%F{magenta}% %~ >%f '";
      };
      system = {
        age = true;
        amd = true;
        boot = true;
        misc = true;
        nix = true;
        user = true;
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
    network = {
      enable = true;
      wait-online.enable = false;
      networks.enp10s0 = {
        name = "enp10s0";
        networkConfig = {
          DHCP = "no";
          DNSSEC = "yes";
          DNSOverTLS = "yes";
          DNS = ["1.0.0.1" "1.1.1.1"];
        };
        address = ["192.168.178.126/24"];
        routes = [{routeConfig.Gateway = "192.168.178.1";}];
      };
    };
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
    };
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    kernelModules = ["amd_pstate"];
    kernelParams = [
      "video=DP-3:1920x1080@165"
      "video=HDMI-A-1:1920x1080@75"
      "initcall_blacklist=acpi_cpu_freq_init"
      "amd_pstate=passive"
      "amd_pstate.shared_mem=1"
    ];
    initrd.supportedFilesystems = ["ntfs"];
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
