{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  options.cute.programs.gui.games = {
    gamemode = lib.mkEnableOption "";
    misc = lib.mkEnableOption "";
    steam = lib.mkEnableOption "";
  };
  config = let
    inherit (config.cute.programs.gui.games) gamemode misc steam;
    inherit (lib) mkMerge mkIf;
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
        users.users.pagu.extraGroups = lib.mkIf gamemode ["gamemode"];
      })
      (mkIf misc {
        environment.systemPackages = builtins.attrValues {
          inherit
            (pkgs)
            prismlauncher
            r2modman
            ;
          osu = inputs.nix-gaming.packages.${pkgs.system}.osu-lazer-bin;
        };
        nix.settings = {
          substituters = ["https://nix-gaming.cachix.org"];
          trusted-public-keys = ["nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="];
        };
        hardware.xone.enable = true;
      })
      (mkIf steam {
        programs.steam = {
          enable = true;
          extraCompatPackages = [pkgs.proton-ge-bin];
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
