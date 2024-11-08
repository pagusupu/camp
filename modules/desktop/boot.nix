{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}: {
  options.cute.desktop.boot = cutelib.mkEnable;
  config = let
    systemd = {
      services.systemd-udev-settle.enable = false;
      network.wait-online.enable = false;
    };
  in
    lib.mkIf config.cute.desktop.boot {
      boot = {
        plymouth = {
          enable = true;
          theme = "bgrt";
          themePackages = [pkgs.nixos-bgrt-plymouth];
        };
        initrd = {
          verbose = false;
          inherit systemd;
        };
        kernelParams = ["quiet" "splash"];
      };
      inherit systemd;
    };
}
