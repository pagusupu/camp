{
  pkgs,
  config,
  ...
}: {
  cute = {
    system = {
      web = {
        domain = "pagu.cafe";
        forgejo.enable = true;
        jellyfin.enable = true;
        komga.enable = true;
        navidrome.enable = true;
        nextcloud.enable = true;
        nginx.enable = true;
        vaultwarden.enable = true;
      };
      misc = {
        conduit.enable = false;
        fail2ban.enable = true;
        homeassistant.enable = true;
        mailserver.enable = true;
      };
    };
    common = {
      programs = {
        htop.enable = true;
        nixvim.enable = true;
        zsh = {
          enable = true;
          prompt = "'%F{yellow}% %~ >%f '";
        };
      };
      misc = {
        age.enable = true;
        console.enable = true;
        nix.enable = true;
      };
    };
  };
  time.timeZone = "NZ";
  i18n.defaultLocale = "en_NZ.UTF-8";
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
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMGwCFQYJB+4nhIqktQwJemynSOEP/sobnV2vESSY3tk" # desktop nixos
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIqJoNQ+5r3whthoNHP3C++gI/KE6iMgrD81K6xDQ//V" # desktop windows
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAqzdZDv69pd3yQEIiq79vRKrDE5PlxINJFhpDvpE/vR" # laptop
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPyA6gv1M1oeN8CnDLR3Z3VdcgK3hbRhHB3Nk6VbWwjK" # phone
    ];
  };
  environment.systemPackages = with pkgs; [
    flac
    git
    go
    hugo
    mdadm
    rnr
    wget
    yazi
  ];
  security.sudo.execWheelOnly = true;
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
    };
  };
  networking = {
    hostName = "nixserver";
    hostId = "a3b49b22";
    firewall.enable = true;
    enableIPv6 = false;
    useDHCP = false;
    defaultGateway = "192.168.178.1";
    nameservers = ["1.1.1.1" "1.0.0.1"];
    interfaces.enp37s0.ipv4.addresses = [
      {
        address = "192.168.178.182";
        prefixLength = 24;
      }
    ];
  };
  hardware = {
    enableRedistributableFirmware = true;
    cpu.amd.updateMicrocode = true;
  };
  boot = {
    loader = {
      timeout = 0;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd.availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"];
    kernelModules = ["kvm-amd" "amdgpu"];
    supportedFilesystems = ["btrfs"];
    swraid.enable = true;
  };
  fileSystems = {
    "/boot" = {
      device = "/dev/disk/by-label/boot";
      fsType = "vfat";
    };
    "/" = {
      device = "/dev/disk/by-label/main";
      fsType = "btrfs";
    };
    "/storage" = {
      device = "/dev/disk/by-label/storage";
      fsType = "btrfs";
    };
  };
  swapDevices = [{device = "/dev/disk/by-label/swap";}];
  # no touchy
  system.stateVersion = "23.11";
}
