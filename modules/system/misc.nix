{
  config,
  lib,
  cutelib,
  ...
}: let
  inherit (cutelib) mkEnabledOption mkEnable;
  inherit (lib) mkMerge mkIf;
  inherit (config.cute.system) cleanup TZ winDualBoot;
in {
  options.cute.system = {
    cleanup = mkEnabledOption;
    TZ = mkEnabledOption;
    winDualBoot = mkEnable;
  };
  config = mkMerge [
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
