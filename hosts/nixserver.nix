{
  cute = {
    services = {
      frge = true;
      grcy = true;
      hass = true;
      jlly = true;
      kmga = true;
      mail = true;
      navi = true;
      next = false;
      qbit = true;
      wrdn = true;
      f2ban = true;
      synapse = true;
      docker = {
        enable = true;
        fish = true;
      };
      nginx = {
        enable = true;
        domain = "pagu.cafe";
      };
    };
    common = {
      age = true;
      console = true;
      htop = true;
      misc = true;
      nix = true;
      nixvim = true;
      tools = true;
      zsh = {
        enable = true;
        prompt = "'%F{yellow}% %~ >%f '";
      };
    };
  };
  users.users.pagu.openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMGwCFQYJB+4nhIqktQwJemynSOEP/sobnV2vESSY3tk" # desktop nixos
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIqJoNQ+5r3whthoNHP3C++gI/KE6iMgrD81K6xDQ//V" # desktop windows
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIAqzdZDv69pd3yQEIiq79vRKrDE5PlxINJFhpDvpE/vR" # laptop
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPyA6gv1M1oeN8CnDLR3Z3VdcgK3hbRhHB3Nk6VbWwjK" # phone
  ];
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
    enableIPv6 = false;
    useDHCP = false;
    defaultGateway = "192.168.178.1";
    interfaces.enp37s0.ipv4.addresses = [
      {
        address = "192.168.178.182";
        prefixLength = 24;
      }
    ];
  };
  boot = {
    loader = {
      timeout = 0;
      systemd-boot.enable = true;
    };
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
