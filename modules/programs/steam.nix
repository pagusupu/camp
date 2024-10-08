{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}: {
  options.cute.programs.steam = cutelib.mkEnable;
  config = lib.mkIf config.cute.programs.steam (lib.mkMerge [
    {
      programs.steam = {
        enable = true;
        package = pkgs.steam.override {extraLibraries = pkgs: [pkgs.wqy_zenhei];};
        extest.enable = true;
        localNetworkGameTransfers.openFirewall = true;
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
            SDL_VIDEODRIVER = "x11"; # games supposedly prefer this
            WLR_RENDERER = "vulkan";
          };
        };
        extraCompatPackages = [pkgs.proton-ge-bin];
      };
      hardware.xone.enable = true;
      # https://github.com/fufexan/nix-gaming/blob/master/modules/platformOptimizations.nix
      boot.kernel.sysctl = {
        "kernel.sched_cfs_bandwidth_slice_us" = 3000;
        "net.ipv4.tcp_fin_timeout" = 5;
        "vm.max_map_count" = 2147483642;
      };
      environment.sessionVariables.WINEDEBUG = "-all"; # also supposedly helps
    }
    {
      programs.gamemode = {
        enable = true;
        enableRenice = true;
        settings = {
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
