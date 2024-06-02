{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  inherit (lib) mkEnableOption mkMerge mkIf;
in {
  imports = [inputs.nix-gaming.nixosModules.platformOptimizations];
  options.cute.programs.gui = {
    gamemode = mkEnableOption "";
    steam = mkEnableOption "";
  };
  config = let
    inherit (config.cute.programs.gui) gamemode steam;
  in
    mkMerge [
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
      (mkIf gamemode {
        programs.gamemode = {
          enable = true;
          enableRenice = true;
          settings = {
            general.renice = 10;
            gpu = {
              amd_performance_level = "high";
              apply_gpu_optimisations = "accept-responsibility";
              gpu_device = 0;
            };
          };
        };
        users.users.pagu.extraGroups = ["gamemode"];
      })
    ];
}
