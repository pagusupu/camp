{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.agenix.nixosModules.default];
  options.cute.common.system = {
    age = lib.mkEnableOption "";
    amd = lib.mkEnableOption "";
    boot = lib.mkEnableOption "";
    hardware = lib.mkEnableOption "";
    misc = lib.mkEnableOption "";
    nix = lib.mkEnableOption "";
    user = lib.mkEnableOption "";
  };
  config = let
    inherit (config.cute.common.system) age amd boot hardware misc nix user;
  in {
    age.identityPaths = lib.mkIf age ["/home/pagu/.ssh/id_ed25519"];
    environment.systemPackages = lib.mkIf age [inputs.agenix.packages.${pkgs.system}.default];
    time.timeZone = lib.mkIf misc "NZ";
    i18n.defaultLocale = lib.mkIf misc "en_NZ.UTF-8";
    security.sudo.execWheelOnly = lib.mkIf misc true;
    networking = lib.mkIf misc {
      firewall.enable = true;
      nameservers = ["1.0.0.1" "1.1.1.1"];
    };
    age.secrets.user = lib.mkIf user {
      file = ../../secrets/user.age;
      owner = "pagu";
    };
    users.users.pagu = lib.mkIf user {
      uid = 1000;
      isNormalUser = true;
      extraGroups = ["wheel"];
      shell = pkgs.zsh;
      hashedPasswordFile = config.age.secrets.user.path;
    };
    hardware = lib.mkIf hardware {
      enableRedistributableFirmware = true;
      cpu.amd.updateMicrocode = lib.mkIf amd true;
      opengl = {
        enable = true;
        extraPackages = with pkgs; [
          vaapiVdpau
          libvdpau-va-gl
        ];
      };
    };
    boot = lib.mkIf boot {
      loader.efi.canTouchEfiVariables = true;
      initrd = {
        supportedFilesystems = ["btrfs"];
        kernelModules = lib.mkIf amd ["kvm-amd" "amdgpu"];
        availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"];
      };
    };
    nix = lib.mkIf nix {
      settings = {
        experimental-features = [
          "flakes"
          "nix-command"
        ];
        auto-optimise-store = true;
        allowed-users = ["@wheel"];
      };
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
    };
    nixpkgs = lib.mkIf nix {
      hostPlatform = "x86_64-linux";
      config.allowUnfree = true;
    };
  };
}
