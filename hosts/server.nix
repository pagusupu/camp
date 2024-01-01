{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  cute = {
    misc = {
      age.enable = true;
      console.enable = true;
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
    services = {
      forgejo.enable = true;
   #  homeassistant.enable = true; insecure component
      jellyfin.enable = true;
      komga.enable = true;
      nextcloud.enable = true;
      vaultwarden.enable = true;
      nginx = {
	enable = true;
	domain = "pagu.cafe";
      };
    };
  };
  time.timeZone = "NZ";
  i18n.defaultLocale = "en_NZ.UTF-8";
  age.secrets.user.file = ../secrets/user.age;
  users.users.pagu = {
    uid = 1000;
    isNormalUser = true;
    extraGroups = ["wheel"];
    shell = pkgs.zsh;
    hashedPasswordFile = config.age.secrets.user.path;
  };
  environment.systemPackages = with pkgs; [
  # general
    git
    go # just for hugo 
    hugo
    mdadm
    wget
  # file management
    flac
    rnr
    yazi
  # command alts
    bat # cat
    eza # ls
    rm-improved # rm
  ];
  security.sudo.execWheelOnly = true;
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
    };
  };
  networking = {
    hostName = "nixserver";
    hostId = "a3b49b22";
    firewall.enable = true;
    enableIPv6 = false;
    useDHCP = false;
    defaultGateway = "192.168.178.1";
    nameservers = ["192.168.178.1"];
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
