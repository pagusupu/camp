{
  config,
  lib,
  pkgs,
  ...
}: {
  options.cute.common.system.amd = lib.mkEnableOption "";
  config = lib.mkIf config.cute.common.system.amd {
    hardware = {
      cpu.amd.updateMicrocode = true;
      opengl = {
        enable = true;
        extraPackages = with pkgs; [
          vaapiVdpau
          libvdpau-va-gl
        ];
      };
    };
    boot.kernelModules = ["kvm-amd" "amdgpu"];
  };
}
