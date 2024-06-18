{
  cute = {
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
    services = {
      homeassistant = true;
      nginx = true;
      synapse = true;
      docker = {
        enable = true;
        feishin = true;
      };
      web = {
        cinny.enable = true;
        jellyfin.enable = true;
        komga.enable = true;
        linkding.enable = true;
        navidrome.enable = true;
        nextcloud.enable = true;
        qbittorrent.enable = true;
        vaultwarden.enable = true;
      };
    };
    net = {
      ip = "192.168.178.182";
      interface = "enp37s0";
    };
    theme.name = "rose-pine";
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
    kernelModules = ["kvm-amd"];
    initrd = {
      availableKernelModules = ["ahci" "nvme" "sd_mod" "xhci_pci"];
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
      options = ["fmask=0022" "dmask=0022"];
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
