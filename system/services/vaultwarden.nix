{
  config,
  lib,
  ...
}: {
  options.cute.services.vaultwarden.enable = lib.mkEnableOption "";
  config = let
    domain = "vault.${config.cute.services.nginx.domain}";
  in
    lib.mkIf config.cute.services.vaultwarden.enable {
      services = {
        vaultwarden = {
          enable = true;
          config = {
            DOMAIN = "https://vault.pagu.cafe";
            SIGNUPS_ALLOWED = true;
            ROCKET_ADDRESS = "127.0.0.1";
            ROCKET_PORT = 8222;
          };
          backupDir = "/storage/services/vaultwarden";
        };
        nginx.virtualHosts."${domain}" = {
          forceSSL = true;
          enableACME = true;
          locations."/" = {
            proxyPass = "http://127.0.0.1:${toString config.services.vaultwarden.config.ROCKET_PORT}";
            extraConfig = "proxy_pass_header Authorization;";
          };
        };
      };
    };
}
