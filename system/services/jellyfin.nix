{
  config,
  lib,
  ...
}: {
  options.cute.services.jellyfin = {
    enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.cute.services.jellyfin.enable {
    services.jellyfin = {
      enable = true;
      openFirewall = true;
    };
  };
}
