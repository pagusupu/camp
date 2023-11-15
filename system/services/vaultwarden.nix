{
  config,
  lib,
  ...
}: {
  options.cute.services.vaultwarden = {
    enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.cute.services.vaultwarden.enable {
    services.vaultwarden = {
      enable = true;
      config = {
        DOMAIN = "https://vault.pagu.cafe";
        SIGNUPS_ALLOWED = true;
        ROCKET_ADDRESS = "127.0.0.1";
        ROCKET_PORT = 8222;
      };
      backupDir = "/mnt/storage/services/vaultwarden";
    };
  };
}
