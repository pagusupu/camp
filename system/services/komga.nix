{config, lib, ...}: {
  options.cute.services.komga = {
    enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.cute.services.komga.enable {
    services.komga = {
      enable = true;
      openFirewall = true;
      port = 8097;
    };
  };
}
