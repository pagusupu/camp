{
  pkgs,
  config,
  lib,
  mcolours,
  ...
}: {
  imports = [../misc/colours.nix];
  options.local.programs.swayfx = {
    enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.local.programs.swayfx.enable {
    home = {
      packages = [pkgs.swayfx];
      file.".config/sway/config".text = let
        d1 = "DP-3";
        d2 = "HDMI-A-1";
        b1 = "~/Nix/things/images/bg1.png";
        b2 = "~/Nix/things/images/bg2.png";
      in ''
        set $mod Mod4
        set $term alactritty
        set $menu tofi-drun --drun-launch true --terminal alacritty

        output ${d1} resolution 1920x1080@165 position 1920,0
        output ${d2} resoultion 1920x1080@75 position 0,0
      '';
    };
  };
}
