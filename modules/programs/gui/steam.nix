{
  config,
  lib,
  cutelib,
  inputs,
  pkgs,
  ...
}: {
  imports = [ inputs.nix-gaming.nixosModules.platformOptimizations ];
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
          extraCompatPackages = [ pkgs.proton-ge-bin ];
          localNetworkGameTransfers.openFirewall = true;
          platformOptimizations.enable = true;
          protontricks.enable = true;
        };
        gamescope.capSysNice = true;
      };
      environment = {
        sessionVariables.WINEDEBUG = "-all";
        systemPackages = [ pkgs.adwsteamgtk ];
      };
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
      users.users.pagu.extraGroups = [ "gamemode" ];
    }
  ]);
}
