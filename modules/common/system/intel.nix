{
  config,
  lib,
  pkgs,
  ...
}: {
  options.cute.common.system.intel = lib.mkEnableOption "";
  config = lib.mkIf config.cute.common.system.intel {
    hardware = {
      cpu.intel.updateMicrocode = true;
      opengl = {
        enable = true;
        extraPackages = with pkgs; [
          intel-media-driver
          intel-compute-runtime
        ];
      };
    };
    boot.kernelModules = ["kvm-intel"];
  };
}
