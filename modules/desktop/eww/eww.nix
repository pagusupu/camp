{
  config,
  lib,
  pkgs,
  ...
}: {
  options.cute.desktop.programs.eww = lib.mkEnableOption "";
  config = lib.mkIf config.cute.desktop.programs.eww {
    home-manager.users.pagu = {
      programs.eww = {
        enable = true;
        package = pkgs.eww-wayland;
        configDir = ./yuck;
      };
    };
  };
}
