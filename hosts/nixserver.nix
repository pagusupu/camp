{
  cute = {
    enabled.net = {
      ip = "192.168.178.182";
      interface = "enp37s0";
    };
    services = {
      fail2ban = true;
      homeassistant = true;
      mailserver = true;
      synapse = true;
      docker = {
        enable = true;
        fish = true;
      };
      media = {
        jlly = true;
        kmga = true;
        navi = true;
        qbit = true;
      };
      storage = {
        file = false;
        prsm = false;
        sync = true;
      };
      web = {
        cube = true;
        frge = true;
        grcy = true;
        nginx = true;
        wrdn = true;
      };
    };
    programs.cli = {
      misc = true;
      nvim = true;
      ssh = true;
      starship = true;
      yazi = true;
      zsh.enable = true;
    };
    system.opengl = true;
  };
  networking = {
    domain = "pagu.cafe";
    hostName = "nixserver";
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
      supportedFilesystems = ["btrfs"];
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
