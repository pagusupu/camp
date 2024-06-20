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
    localsend = mkEnableOption "";
  };
  config = let
    inherit (config.cute.programs.gui) aagl gamemode localsend;
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
            custom = {
              start = "notify-send 'Gamemode' 'Optimizations enabled'";
              end = "notify-send 'Gamemode' 'Optimizations disabled'";
            };
          };
        };
        users.users.pagu.extraGroups = ["gamemode"];
      })
      (mkIf localsend {
        environment.systemPackages = [pkgs.localsend];
        networking.firewall = {
          allowedTCPPorts = [53317];
          allowedUDPPorts = [53317];
        };
      })
    ];
}
