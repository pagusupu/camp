{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}: {
  options.cute.desktop.boot = cutelib.mkEnable;
  config = lib.mkIf config.cute.desktop.boot {
    boot = {
      plymouth = {
        #enable = true;
        theme = "bgrt";
        themePackages = [ pkgs.nixos-bgrt-plymouth ];
      };
      initrd = {
        systemd = {
          enable = true;
          services.systemd-udev-settle.enable = false;
          network.wait-online.enable = false;
        };
        verbose = false;
      };
      kernelParams = [ "quiet" "splash" ];
    };
  };
}
