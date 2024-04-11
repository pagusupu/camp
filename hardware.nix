{
  config,
  lib,
  ...
}: {
  options.cute.common.system = {
    plymouth = lib.mkEnableOption "";
    hardware = {
      enable = lib.mkEnableOption "";
      amd = lib.mkEnableOption "";
      intel = lib.mkEnableOption "";
    };
  };
  config = let
    inherit (config.cute.common.system.hardware) enable amd intel;
  in
    lib.mkIf enable {
      hardware = {
        cpu = {
          amd.updateMicrocode = lib.mkIf amd true;
          intel.updateMicrocode = lib.mkIf intel true;
        };
      };
    };
}
