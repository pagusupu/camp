{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}: let
  inherit (cutelib) mkEnabledOption mkEnable;
  inherit (lib) mkMerge mkIf;
in {
  options.cute.system = {
    cleanup = mkEnabledOption;
    graphics = mkEnable;
    programs = mkEnabledOption;
    sudo = mkEnabledOption;
    TZ = mkEnabledOption;
    winDualBoot = mkEnable;
  };
  config = let
    inherit (config.cute.system) cleanup graphics programs sudo TZ winDualBoot;
  in
    mkMerge [
      (mkIf cleanup {
        documentation = {
          enable = false;
          doc.enable = false;
          info.enable = false;
          nixos.enable = false;
        };
        programs = {
          bash.completion.enable = false;
          command-not-found.enable = false;
          nano.enable = false;
        };
        boot.enableContainers = false;
        xdg.sounds.enable = false;
      })
      (mkIf graphics {
        hardware.graphics = {
          enable = true;
          extraPackages = with pkgs; [
            libvdpau-va-gl
            vaapiVdpau
          ];
          enable32Bit = true;
        };
      })
      (mkIf programs {
        environment.systemPackages = with pkgs; [
          ouch
          wget
        ];
      })
      (mkIf sudo {
        security.sudo-rs = {
          enable = true;
          execWheelOnly = true;
          wheelNeedsPassword = mkIf (config.networking.hostName == "rin") false;
        };
      })
      (mkIf TZ {
        i18n.defaultLocale = "en_NZ.UTF-8";
        time.timeZone = "NZ";
      })
      (mkIf winDualBoot {
        boot = {
          supportedFilesystems.ntfs = true;
          loader.grub.useOSProber = true;
        };
        time.hardwareClockInLocalTime = true;
        security.tpm2.enable = true;
      })
    ];
}
