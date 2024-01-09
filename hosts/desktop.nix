{
  pkgs,
  config,
  inputs,
  ...
}: {
  cute = {
    misc = {
      age.enable = true;
      console.enable = true;
      fonts.enable = true;
      nix.enable = true;
      shell = {
        enable = true;
        prompt = "'%F{magenta}% %~ >%f '";
      };
    };
    programs = {
      htop.enable = true;
      nixvim.enable = true;
    };
    wayland = {
      programs = {
        hyprland.enable = true;
      };
      misc = {
        greetd.enable = true;
      };
    };
  };
  i18n.defaultLocale = "en_NZ.UTF-8";
  time = {
    timeZone = "NZ";
    hardwareClockInLocalTime = true;
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
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {inherit inputs;};
    users.pagu = {
      imports = [
        ../system/misc/colours.nix
        ../user
      ];
      hm.programs = {
        alacritty.enable = true;
        firefox.enable = true;
        hyprland.config = true;
        mako.enable = true;
        swaylock.enable = true;
        waybar.enable = true; 
      };
      home = {
        username = "pagu";
        homeDirectory = "/home/pagu";
        packages = with pkgs; [
          osu-lazer-bin
          prismlauncher-qt5
          r2modman
          xivlauncher
          protontricks
          protonup-ng
          vesktop
          ueberzugpp
          yazi
          wl-clipboard
          imv
          hyprshot
          gnome.nautilus
	  tofi
        ];
        sessionVariables = {
          EDITOR = "nvim";
          MOZ_ENABLE_WAYLAND = 1;
        };
        stateVersion = "23.05";
      };
      programs.git = {
        enable = true;
        userName = "pagusupu";
        userEmail = "me@pagu.cafe";
      };
    };
  };
  programs = {
    steam.enable = true;
  };
  services = {
    blueman.enable = true;
    dbus.enable = true;
    sshd.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      pulse.enable = true;
    };
  };
  security = {
    rtkit.enable = true;
    tpm2.enable = true;
    pam.services.swaylock = {};
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
      };
      efi.canTouchEfiVariables = true;
    };
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
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
  };
  networking = {
    dhcpcd.wait = "background";
    hostName = "desktop";
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
