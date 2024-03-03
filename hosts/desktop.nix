{pkgs, ...}: {
  cute = {
    desktop = {
      alacritty = true;
      audio = true;
      firefox = true;
      fonts = true;
      games = true;
      greetd = true;
      gtk = true;
      hyprland = true;
      mako = true;
      misc = true;
      swaylock = true;
      wofi = true;
      xdg = true;
    };
    home = {
      enable = true;
      ags = false;
      themes.firefox = true;
    };
    common = {
      age = true;
      console = true;
      git = true;
      htop = true;
      nix = true;
      nixvim = true;
      zsh = {
        enable = true;
        prompt = "'%F{magenta}% %~ >%f '";
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
  };
  powerManagement.cpuFreqGovernor = "schedutil";
  networking = {
    dhcpcd.wait = "background";
    hostName = "desktop";
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
  # no touchy
  system.stateVersion = "23.11";
}
