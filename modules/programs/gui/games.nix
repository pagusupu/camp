{
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  inherit (lib) mkEnableOption mkMerge mkIf;
in {
  imports = [
    inputs.aagl.nixosModules.default
    inputs.nix-gaming.nixosModules.platformOptimizations
  ];
  options.cute.programs.gui = {
    aagl = mkEnableOption "";
    gamemode = mkEnableOption "";
    steam = mkEnableOption "";
  };
  config = let
    inherit (config.cute.programs.gui) aagl gamemode steam;
  in
    mkMerge [
      (mkIf aagl {
        nix.settings = {
          substituters = ["https://ezkea.cachix.org"];
          trusted-public-keys = ["ezkea.cachix.org-1:ioBmUbJTZIKsHmWWXPe1FSFbeVe+afhfgqgTSNd34eI="];
        };
        programs.honkers-railway-launcher.enable = true;
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
      (mkIf steam {
        programs.steam = {
          enable = true;
          extraCompatPackages = [pkgs.proton-ge-bin];
          platformOptimizations.enable = true;
          gamescopeSession = {
            enable = true;
            args = [
              "-H 1080" # height, assumes 16:9
              "-r 165" # refresh rate
              "-e" # steam integration
              "--expose-wayland"
            ];
            env = {
              SDL_VIDEODRIVER = "x11";
              WLR_RENDERER = "vulkan";
            };
          };
        };
        environment = {
          sessionVariables = {WINEDEBUG = "-all";};
          systemPackages = [pkgs.protontricks];
        };
        hardware.xone.enable = true;
      })
    ];
}
