{
  config,
  lib,
  ...
}: {
  options.cute.desktop.misc.gamemode = lib.mkOption {
    type = lib.types.bool;
    default = config.programs.steam.enable;
  };
  config = lib.mkIf config.cute.desktop.misc.gamemode {
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
  };
}
