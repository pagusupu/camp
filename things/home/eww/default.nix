{
  lib,
  config,
  ...
}: {
  options.cute.programs.eww = {
    enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.cute.programs.eww.enable {
    programs.eww = {
      enable = true;
      configDir = ./config;
    };
  };
}
