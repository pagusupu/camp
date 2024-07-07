{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.nix-gaming.nixosModules.platformOptimizations];
  options.cute.programs.gui.steam = lib.mkEnableOption "";
  config = lib.mkIf config.cute.programs.gui.steam (lib.mkMerge [
    {
      programs.steam = {
        enable = true;
        localNetworkGameTransfers.openFirewall = true;
        platformOptimizations.enable = true;
        protontricks.enable = true;
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
        extraCompatPackages = [pkgs.proton-ge-bin];
      };
      environment.sessionVariables.WINEDEBUG = "-all";
      hardware.xone.enable = true;
    }
    {
      programs.gamemode = {
        enable = true;
        enableRenice = true;
        settings = {
          custom = {
            start = "notify-send 'Gamemode' 'Optimizations enabled'";
            end = "notify-send 'Gamemode' 'Optimizations disabled'";
          };
          gpu = {
            amd_performance_level = "high";
            apply_gpu_optimisations = "accept-responsibility";
            gpu_device = 0;
          };
          general.renice = 10;
        };
      };
      users.users.pagu.extraGroups = ["gamemode"];
    }
  ]);
}
