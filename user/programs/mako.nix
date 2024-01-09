{
  config,
  lib,
  ...
}: {
  options.hm.programs.mako.enable = lib.mkEnableOption "";
  config = lib.mkIf config.hm.programs.mako.enable {
    services.mako = {
      enable = true;
    };
  };
}
