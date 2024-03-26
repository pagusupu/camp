{
  cute = {
    services = {
      cube = true;
      file = false;
      frge = true;
      grcy = true;
      jlly = true;
      kmga = true;
      navi = true;
      prsm = false;
      qbit = true;
      sync = true;
      wrdn = true;
      fail2ban = true;
      homeassistant = true;
      mailserver = true;
      synapse = true;
      nginx = true;
      docker = {
        enable = true;
        fish = true;
      };
    };
    common = {
      git = true;
      nixvim = true;
      ssh = true;
      tools = true;
      yazi = true;
      zsh = {
        enable = true;
        starship = true;
      };
      system = {
        nix = true;
        user = true;
        hardware = {
          enable = true;
          amd = true;
          boot = true;
        };
      };
    };
  };
  users.users.pagu.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMGwCFQYJB+4nhIqktQwJemynSOEP/sobnV2vESSY3tk" # desktop nixos
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIqJoNQ+5r3whthoNHP3C++gI/KE6iMgrD81K6xDQ//V" # desktop windows
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAqzdZDv69pd3yQEIiq79vRKrDE5PlxINJFhpDvpE/vR" # laptop
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPyA6gv1M1oeN8CnDLR3Z3VdcgK3hbRhHB3Nk6VbWwjK" # phone
  ];
  networking = {
    domain = "pagu.cafe";
    hostName = "nixserver";
    hostId = "a3b49b22";
  };
  systemd.network = {
    enable = true;
    networks.enp37s0 = {
      enable = true;
      name = "enp37s0";
      networkConfig = {
        DHCP = "no";
        DNSSEC = "yes";
        DNSOverTLS = "yes";
        DNS = ["1.0.0.1" "1.1.1.1"];
      };
      address = ["192.168.178.182/24"];
      routes = [{routeConfig.Gateway = "192.168.178.1";}];
    };
  };
  boot = {
    loader = {
      timeout = 0;
      systemd-boot.enable = true;
    };
    initrd = {
      availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"];
      supportedFilesystems = ["btrfs"];
    };
    kernelModules = ["kvm-amd" "amdgpu"];
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
