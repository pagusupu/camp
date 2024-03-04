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
    boot = lib.mkEnableOption "";
    misc = lib.mkEnableOption "";
    user = lib.mkEnableOption "";
  };
  config = let
    inherit (config.cute.common.system) age boot misc user;
  in {
    age.identityPaths = lib.mkIf age ["/home/pagu/.ssh/id_ed25519"];
    environment.systemPackages = lib.mkIf age [inputs.agenix.packages.${pkgs.system}.default];
    time.timeZone = lib.mkIf misc "NZ";
    i18n.defaultLocale = lib.mkIf misc "en_NZ.UTF-8";
    security.sudo.execWheelOnly = lib.mkIf misc true;
    hardware.enableRedistributableFirmware = lib.mkIf misc true;
    networking = lib.mkIf misc {
      firewall.enable = true;
      enableIPv6 = false;
      useDHCP = false;
    };
    age.secrets.user = lib.mkIf user {
      file = ../../../secrets/user.age;
      owner = "pagu";
    };
    users.users.pagu = lib.mkIf user {
      uid = 1000;
      isNormalUser = true;
      extraGroups = ["wheel"];
      shell = pkgs.zsh;
      hashedPasswordFile = config.age.secrets.user.path;
    };

    boot = lib.mkIf boot {
      loader.efi.canTouchEfiVariables = true;
      initrd = {
        supportedFilesystems = ["btrfs"];
        availableKernelModules = ["nvme" "xhci_pci" "ahci" "usb_storage" "usbhid" "sd_mod"];
      };
    };
  };
}
