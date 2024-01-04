{
  config,
  lib,
  ...
}: {
  options.cute.services.mailserver.enable = lib.mkEnableOption "";
  config = let
    domain = "${config.cute.services.nginx.domain}";
  in
    lib.mkIf config.cute.services.mailserver.enable {
      age.secrets.mail = {
        file = ../../secrets/mail.age;
        owner = "dovecot2";
      };
      mailserver = {
        enable = true;
        fqdn = "mail.${domain}";
        domains = ["${domain}"];
        loginAccounts = {
          "host@${domain}" = {
            hashedPasswordFile = config.age.secrets.mail.path;
            aliases = ["me@${domain}" "signup@${domain}" "acme@${domain}"];
          };
          "nextcloud@${domain}".hashedPasswordFile = config.age.secrets.mail.path;
        };
        certificateScheme = "acme-nginx";
      };
    };
}
