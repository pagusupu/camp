{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  options.hm.misc.gaming.enable = lib.mkEnableOption "";
  config = lib.mkIf config.hm.misc.gaming.enable {
    home.packages = with pkgs; [
      inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
      prismlauncher-qt5
      protontricks
      r2modman
      xivlauncher
    ];
  };
}
