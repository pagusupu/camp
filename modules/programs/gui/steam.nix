{
  config,
  lib,
  cutelib,
  pkgs,
  ...
}: {
  options.cute.programs.gui.steam = cutelib.mkEnable;
  config = lib.mkIf config.cute.programs.gui.steam (lib.mkMerge [
    {
      programs = {
        steam = {
          enable = true;
          gamescopeSession = {
            enable = true;
            args = [
              "-H 1080"
              "-o 30"
              "-r 165"
              "--expose-wayland"
              "--steam"
            ];
            env = {
              SDL_VIDEODRIVER = "x11";
              WLR_RENDERER = "vulkan";
            };
          };
          extraCompatPackages = [pkgs.proton-ge-bin];
          localNetworkGameTransfers.openFirewall = true;
          protontricks.enable = true;
        };
        gamescope.capSysNice = true;
      };
      environment.systemPackages = [pkgs.adwsteamgtk];
      hardware.xone.enable = true;
    }
    {
      programs.gamemode = {
        enable = true;
        settings = {
          general = {
            desiredgov = "performance";
            renice = 10;
          };
          gpu = {
            amd_performance_level = "high";
            apply_gpu_optimisations = "accept-responsibility";
            gpu_device = 0;
          };
        };
      };
      users.users.pagu.extraGroups = ["gamemode"];
    }
    {
      boot.kernel.sysctl = {
        "kernel.sched_cfs_bandwidth_slice_us" = 3000;
        "net.ipv4.tcp_fin_timeout" = 5;
        "vm.max_map_count" = 2147483642;
      };
      environment.sessionVariables.WINEDEBUG = "-all";
    }
  ]);
}
