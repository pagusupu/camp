{
  lib,
  config,
  pkgs,
  ...
}: {
  options.cute.desktop.programs.misc = lib.mkEnableOption "";
  config = lib.mkIf config.cute.desktop.programs.misc {
    home-manager.users.pagu = {
      home.packages = with pkgs; [
        element-desktop
        localsend
        pwvucontrol
        sublime-music
        ueberzugpp
        vesktop
        xfce.thunar
      ];
    };
    networking.firewall = {
      allowedTCPPorts = [53317];
      allowedUDPPorts = [53317];
    };
  };
}
