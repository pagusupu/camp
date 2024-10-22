{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}: {
  options.cute.desktop.misc.boot = cutelib.mkEnable;
  config = lib.mkIf config.cute.desktop.misc.boot {
    boot = {
      plymouth = {
        enable = true;
        theme = "bgrt";
        themePackages = [pkgs.nixos-bgrt-plymouth];
      };
      initrd.verbose = false;
      kernelParams = ["quiet" "splash"];
    };
    systemd = {
      services.systemd-udev-settle.enable = false;
      network.wait-online.enable = false;
    };
  };
}
