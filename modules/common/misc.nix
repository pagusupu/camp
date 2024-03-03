{
  config,
  lib,
  pkgs,
  ...
}: {
  options.cute.common = {
    misc = lib.mkEnableOption "";
    tools = lib.mkEnableOption "";
  };
  config = let
    inherit (config.cute.common) misc tools;
  in {
    time.timeZone = lib.mkIf misc "NZ";
    i18n.defaultLocale = lib.mkIf misc "en_NZ.UTF-8";
    security.sudo.execWheelOnly = lib.mkIf misc true;
    age.secrets.user = lib.mkIf misc {
      file = ../../secrets/user.age;
      owner = "pagu";
    };
    users.users.pagu = lib.mkIf misc {
      uid = 1000;
      isNormalUser = true;
      extraGroups = ["wheel"];
      shell = pkgs.zsh;
      hashedPasswordFile = config.age.secrets.user.path;
    };
    networking = lib.mkIf misc {
      firewall.enable = true;
      nameservers = ["1.0.0.1" "1.1.1.1"];
    };
    hardware = lib.mkIf misc {
      enableRedistributableFirmware = true;
      cpu.amd.updateMicrocode = true;
      opengl = {
        enable = true;
        extraPackages = with pkgs; [
          vaapiVdpau
          libvdpau-va-gl
        ];
      };
    };
    boot = lib.mkIf misc {
      loader.efi.canTouchEfiVariables = true;
      initrd = {
        supportedFilesystems = ["btrfs"];
        kernelModules = ["kvm-amd" "amdgpu"];
        availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"];
      };
    };
    environment = lib.mkIf tools {
      systemPackages = with pkgs; [
        bat
        btop
        dust
        eza
        fzf
        git
        nh
        rm-improved
        tldr
        wget
        yazi
        zoxide
      ];
    };
  };
}
