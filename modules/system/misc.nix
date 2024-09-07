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
    hardware = {
      enableRedistributableFirmware = true;
      graphics.enable = true;
    };
    programs = {
      bash.completion.enable = false;
      command-not-found.enable = false;
      nano.enable = false;
    };
    environment.variables = let
      d = "/home/pagu/";
    in {
      XDG_CACHE_HOME = d + ".cache";
      XDG_CONFIG_HOME = d + ".config";
      XDG_DATA_HOME = d + ".local/share";
      XDG_STATE_HOME = d + ".local/state";
    };
  };
}
