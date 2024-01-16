{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [
    inputs.nix-gaming.nixosModules.pipewireLowLatency
    inputs.nix-gaming.nixosModules.steamCompat
  ];
  options.cute.desktop.misc.gaming.enable = lib.mkEnableOption "";
  config = lib.mkIf config.cute.desktop.misc.gaming.enable {
    home-manager.users.pagu = {
      home.packages = with pkgs; [
        inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
        prismlauncher-qt5
        protontricks
        r2modman
        xivlauncher
      ];
    };
    programs.steam = {
      enable = true;
      extraCompatPackages = [
        inputs.nix-gaming.packages.${pkgs.system}.proton-ge
      ];
    };
    nix.settings = {
      substituters = ["https://nix-gaming.cachix.org"];
      trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
    };
  };
}
