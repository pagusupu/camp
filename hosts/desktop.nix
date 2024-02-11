{
  pkgs,
  config,
  ...
}: {
  cute = {
    desktop = {
      programs = {
        alacritty = true;
        firefox = true;
        games = true;
        hyprland = true;
        mako = true;
        misc = true;
        swaylock = true;
        wofi = true;
      };
      misc = {
        audio = true;
        fonts = true;
        greetd = true;
        hm = true;
        xdg = true;
      };
      themes = {
        firefox = true;
        gtk = true;
      };
      eww = true;
    };
    common = {
      age = true;
      console = true;
      htop = true;
      nix = true;
      nixvim = true;
      zsh = {
        enable = true;
        prompt = "'%F{magenta}% %~ >%f '";
      };
    };
  };
  i18n.defaultLocale = "en_NZ.UTF-8";
  time = {
    timeZone = "NZ";
    hardwareClockInLocalTime = true; # windows
  };
  age.secrets.user = {
    file = ../secrets/user.age;
    owner = "pagu";
  };
  users.users.pagu = {
    uid = 1000;
    isNormalUser = true;
    extraGroups = ["wheel"];
    shell = pkgs.zsh;
    hashedPasswordFile = config.age.secrets.user.path;
  };
  services = {
    dbus.enable = true;
    sshd.enable = true;
  };
  security = {
    tpm2.enable = true;
    sudo = {
      execWheelOnly = true;
      wheelNeedsPassword = false;
    };
  };
  boot = {
    kernelPackages = pkgs.linuxPackages_xanmod_latest;
    loader = {
      grub = {
        enable = true;
        efiSupport = true;
        useOSProber = true;
        device = "nodev";
        splashImage = null;
        configurationLimit = 10;
        extraConfig = ''GRUB_TIMEOUT_STYLE=hidden'';
      };
      efi.canTouchEfiVariables = true;
    };
    supportedFilesystems = ["btrfs" "ntfs"];
    kernelModules = ["kvm-amd" "amd_pstate"];
    initrd = {
      kernelModules = ["amdgpu"];
      availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"];
    };
    kernelParams = [
      "video=DP-3:1920x1080@165"
      "video=HDMI-A-1:1920x1080@75"
      "initcall_blacklist=acpi_cpu_freq_init"
      "amd_pstate=passive"
      "amd_pstate.shared_mem=1"
    ];
  };
  powerManagement.cpuFreqGovernor = "schedutil";
  hardware = {
    cpu.amd.updateMicrocode = true;
    enableRedistributableFirmware = true;
    pulseaudio.enable = false;
  };
  networking = {
    dhcpcd.wait = "background";
    hostName = "desktop";
    nameservers = ["1.1.1.1" "1.0.0.1"];
    firewall.enable = true;
    networkmanager.enable = false;
    wireless = {
      enable = true;
      userControlled.enable = true;
      networks."Upstairs-5G" = {
        pskRaw = "690ab0d9f04e21ca329db4f36c9dd4402547dbd94c57def80b210b3311925091";
      };
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
  # no touchy
  system.stateVersion = "23.11";
}
