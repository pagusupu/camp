{
  config,
  lib,
  ...
}: {
  options.cute.system.web.vaultwarden.enable = lib.mkEnableOption "";
  config = let
    domain = "vault.${config.cute.system.web.domain}";
  in
    lib.mkIf config.cute.system.web.vaultwarden.enable {
      services = {
        vaultwarden = {
          enable = true;
          config = {
            DOMAIN = "https://vault.pagu.cafe";
            SIGNUPS_ALLOWED = true;
            ROCKET_ADDRESS = "127.0.0.1";
            ROCKET_PORT = 8222;
            # SMTP_HOST = "mail.pagu.cafe";
            # SMPT_PORT = 465;
            # SMTP_SECURITY = "force_tls";
            # SMTP_FROM = "vaultwarden@pagu.cafe";
            # SMTP_FROM_NAME = "Vaultwarden";
            # SMTP_USERNAME = "vaultwarden@pagu.cafe";
            # SMTP_PASSWORD = "";
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
