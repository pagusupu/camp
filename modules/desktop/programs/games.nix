{
  lib,
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.nix-gaming.nixosModules.steamCompat];
  options.cute.desktop.programs.games = {
    misc = lib.mkEnableOption "";
    steam = lib.mkEnableOption "";
    gamemode = lib.mkEnableOption "";
  };
  config = let
    inherit (config.cute.desktop.programs.games) misc steam gamemode;
  in {
    home-manager.users.pagu = lib.mkIf misc {
      home.packages = with pkgs; [
        inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin
        prismlauncher
        protontricks
        r2modman
      ];
    };
    programs = {
      steam = lib.mkIf steam {
        enable = true;
        extraCompatPackages = [inputs.nix-gaming.packages.${pkgs.system}.proton-ge];
        gamescopeSession = {
          enable = true;
          args = ["-H 1080 -r 165 -e --expose-wayland"];
        };
      };
      gamemode = lib.mkIf gamemode {
        enable = true;
        enableRenice = true;
        settings = {
          general.renice = 10;
          gpu = {
            apply_gpu_optimisations = "accept-responsibility";
            gpu_device = 0;
            amd_performance_level = "high";
          };
          custom = {
            start = "${pkgs.libnotify}/bin/notify-send 'Gamemode started'";
            end = "${pkgs.libnotify}/bin/notify-send 'Gamemode ended'";
          };
        };
      };
    };
    users.users.pagu.extraGroups = lib.mkIf gamemode ["gamemode"];
    hardware = lib.mkIf misc {
      xone.enable = true;
      opengl = {
        driSupport = true;
        driSupport32Bit = true;
      };
    };
    nix.settings = lib.mkIf misc {
      substituters = ["https://nix-gaming.cachix.org"];
      trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
    };
  };
}
