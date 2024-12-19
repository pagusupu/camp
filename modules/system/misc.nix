{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}: let
  inherit (cutelib) mkEnabledOption mkEnable;
  inherit (lib) mkOption types mkMerge mkIf;
  inherit (types) nullOr enum;
in {
  options.cute.system = {
    cleanup = mkEnabledOption;
    hardware = mkOption { type = nullOr (enum [ "amd" "intel" ]); };
    programs = mkEnabledOption;
    sudo = mkEnabledOption;
    TZ = mkEnabledOption;
    winDualBoot = mkEnable;
  };
  config = let
    inherit (config.cute.system) cleanup hardware programs sudo TZ winDualBoot;
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
      {
        hardware = mkMerge [
          (mkIf (hardware == "amd") {
            cpu.amd.updateMicrocode = true;
            graphics.extraPackages = with pkgs; [ libvdpau-va-gl vaapiVdpau ];
          })
          (mkIf (hardware == "intel") {
            cpu.intel.updateMicrocode = true;
            #graphics.extraPackages = with pkgs; [];
          })
          {
            graphics.enable = true;
            enableRedistributableFirmware = true;
          }
        ];
      }
      (mkIf programs {
        environment.systemPackages = with pkgs; [
          dust
          nurl
          ouch
          wget
        ];
      })
      (mkIf sudo {
        security.sudo-rs = {
          enable = true;
          execWheelOnly = true;
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
      { boot.kernelPackages = lib.mkDefault pkgs.linuxPackages_latest; }
    ];
}
