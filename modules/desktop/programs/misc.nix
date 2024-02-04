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
        imv
        localsend
        xfce.thunar
      ];
    }; 
  };
}
