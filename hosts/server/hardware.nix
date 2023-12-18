{pkgs, ...}: {
  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
    initrd = {
      availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"];
    };
    kernelModules = ["kvm-amd" "amdgpu"];
    supportedFilesystems = ["btrfs"];
    swraid.enable = true;
  };
  hardware = {
    enableRedistributableFirmware = true;
    cpu.amd.updateMicrocode = true;
    opengl = {
      enable = true;
      extraPackages = with pkgs; [
        # video encode/decode for jellyfin
        vaapiVdpau
        libvdpau-va-gl
      ];
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
      device = "/dev/md0";
      fsType = "btrfs";
    };
  };
  swapDevices = [{device = "/dev/disk/by-label/swap";}];
}
