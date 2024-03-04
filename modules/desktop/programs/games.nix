{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.nix-gaming.nixosModules.steamCompat];
  options.cute.desktop.programs.games = lib.mkEnableOption "";
  config = lib.mkIf config.cute.desktop.programs.games {
    home-manager.users.pagu = {
      home.packages = with pkgs; [
        inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
        prismlauncher
        protontricks
        r2modman
      ];
    };
    programs.steam = {
      enable = true;
      extraCompatPackages = [inputs.nix-gaming.packages.${pkgs.system}.proton-ge];
      gamescopeSession = {
        enable = true;
        args = ["-H 1080 -r 165 -e --expose-wayland"];
      };
    };
    hardware = {
      xone.enable = true;
      opengl = {
        driSupport = true;
        driSupport32Bit = true;
      };
    };
    nix.settings = {
      substituters = ["https://nix-gaming.cachix.org"];
      trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
    };
  };
}
