{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.desktop.misc = {
    bluetooth = cutelib.mkEnable;
    printing = cutelib.mkEnable;
  };
  config = let
    inherit (config.cute.desktop.misc) bluetooth printing;
  in
    lib.mkMerge [
      (lib.mkIf bluetooth {
        hardware.bluetooth = {
          enable = true;
          settings.General = {
            Enable = "Source,Sink,Media,Socket";
            Experimental = true;
            KernelExperimental = true;
            JustWorksRepairing = "always";
          };
        };
      })
      (lib.mkIf printing {
        services = {
          avahi = {
            enable = true;
            nssmdns4 = true;
          };
          printing.enable = true;
        };
      })
    ];
}
