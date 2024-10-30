{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.desktop.misc.bluetooth = cutelib.mkEnable;
  config = lib.mkIf config.cute.desktop.misc.bluetooth {
    hardware.bluetooth = {
      enable = true;
      settings.General = {
        Enable = "Source,Sink,Media,Socket";
        Experimental = true;
      };
    };
  };
}
