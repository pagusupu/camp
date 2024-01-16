{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: {
  options.cute.hm.misc.games.enable = lib.mkEnableOption "";
  config = lib.mkIf config.cute.hm.misc.games.enable {
    home-manager.users.pagu = {
      home.packages = with pkgs; [
        inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
        prismlauncher-qt5
        protontricks
        r2modman
        xivlauncher
      ];
    };
  };
}
