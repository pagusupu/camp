{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.system.misc = cutelib.mkEnabledOption;
  config = lib.mkIf config.cute.system.misc {
    boot.enableContainers = false;
    i18n.defaultLocale = "en_NZ.UTF-8";
    time.timeZone = "NZ";
    xdg.sounds.enable = false;
    boot = {
      initrd.verbose = false;
      kernelParams = ["quiet" "splash"];
    };
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
  };
}
