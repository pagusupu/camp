{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}: {
  options.cute.desktop.programs.plasma = cutelib.mkEnable;
  config = lib.mkIf config.cute.desktop.programs.plasma {
    services = {
      displayManager = {
        sddm = {
          enable = true;
          wayland.enable = true;
        };
        defaultSession = "plasma";
      };
      desktopManager.plasma6.enable = true;
    };
    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      elisa
      kate
      khelpcenter
      krdp
      kwalletmanager
      plasma-browser-integration
      plasma-workspace-wallpapers
    ];
    programs.dconf.enable = true;
  };
}
