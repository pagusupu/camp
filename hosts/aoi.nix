{
  cute = {
    enabled.net = {
      ip = "192.168.178.182";
      interface = "enp37s0";
    };
    services = {
      docker = {
        enable = true;
        feishin = true;
        linkding = true;
        memos = true;
      };
      matrix = {
        cinny = true;
        synapse = true;
      };
      media = {
        jellyfin = true;
        komga = true;
        navidrome = true;
        qbittorrent = true;
      };
      web = {
        homeassistant = true;
        nextcloud = true;
        nginx = true;
        vaultwarden = true;
      };
    };
    programs.cli = {
      btop = true;
      misc = true;
      nh = true;
      nvim = true;
      ssh = true;
      starship = true;
      yazi = true;
      zsh = true;
    };
  };
  networking = {
    domain = "pagu.cafe";
    hostName = "aoi";
    hostId = "a3b49b22";
  };
  boot = {
    loader = {
      timeout = 0;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    kernelModules = ["kvm-amd" "amdgpu"];
    initrd = {
      availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"];
      supportedFilesystems.btrfs = true;
    };
    swraid.enable = true;
  };
  hardware.cpu.amd.updateMicrocode = true;
  powerManagement.cpuFreqGovernor = "powersave";
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
