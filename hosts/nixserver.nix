{
  cute = {
    services = {
      frge = true;
      grcy = true;
      jlly = true;
      kmga = true;
      mail = true;
      navi = true;
      next = false;
      qbit = true;
      wrdn = true;
      f2ban = true;
      homeassistant = true;
      synapse = true;
      nginx = true;
      docker = {
        enable = true;
        fish = true;
      };
    };
    common = {
      console = true;
      git = true;
      nixvim = true;
      ssh = true;
      tools = true;
      zsh = {
        enable = true;
        prompt = "'%F{yellow}% %~ >%f '";
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
