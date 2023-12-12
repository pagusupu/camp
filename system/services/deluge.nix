{
  config, 
  lib,
  ...
}: {
  options.cute.services.deluge = {
    enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.cute.services.deluge.enable {
    services.deluge = {
      enable = true;
      dataDir = "/storage/services/deluge";
      web = {
        enable = true;
        openFirewall = true;
        port = 8111;
      };
    };
  };
}
