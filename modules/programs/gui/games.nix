{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkMerge mkIf;
in {
  imports = [
    inputs.aagl.nixosModules.default
    inputs.nix-gaming.nixosModules.platformOptimizations
  ];
  options.cute.programs.gui.gaming = {
    gamemode = mkEnableOption "";
    steam = mkEnableOption "";
    games = {
      aagl = mkEnableOption "";
      misc = mkEnableOption "";
      osu = mkEnableOption "";
    };
  };
  config = let
    inherit (config.cute.programs.gui.gaming) gamemode games steam;
  in
    mkMerge [
      (mkIf gamemode {
        programs.gamemode = {
          enable = true;
          enableRenice = true;
          settings = {
            general.renice = 10;
            gpu = {
              apply_gpu_optimisations = "accept-responsibility";
              gpu_device = 0;
              amd_performance_level = "high";
            };
          };
        };
        users.users.pagu.extraGroups = ["gamemode"];
      })
      (mkIf games.aagl {
        nix.settings = {
          substituters = ["https://ezkea.cachix.org"];
          trusted-public-keys = ["ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="];
        };
        programs.honkers-railway-launcher.enable = true;
      })
      (mkIf games.misc {
        environment.systemPackages = builtins.attrValues {
          inherit
            (pkgs)
            heroic
            prismlauncher
            r2modman
            ryujinx
            ;
        };
        hardware.xone.enable = true;
      })
      (mkIf games.osu {
        nix.settings = {
          substituters = ["https://nix-gaming.cachix.org"];
          trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
        };
        environment.systemPackages = [inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin];
      })
      (mkIf steam {
        programs.steam = {
          enable = true;
          extraCompatPackages = [pkgs.proton-ge-bin];
          platformOptimizations.enable = true;
          gamescopeSession = {
            enable = true;
            args = ["-H 1080 -r 165 -e --expose-wayland"];
          };
        };
        hardware.opengl = {
          driSupport = true;
          driSupport32Bit = true;
        };
        environment.systemPackages = [pkgs.protontricks];
      })
    ];
}
