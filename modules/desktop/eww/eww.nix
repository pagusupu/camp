{
  config,
  lib,
  pkgs,
  ...
}: {
  options.cute.desktop.eww = lib.mkEnableOption "";
  config = lib.mkIf config.cute.desktop.eww {
    home-manager.users.pagu = {
      programs.eww = {
        enable = true;
        package = pkgs.eww-wayland;
        configDir = ./yuck;
      };
      home.packages = with pkgs; [
        jq
        socat
      ];
    };
  };
}
