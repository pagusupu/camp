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
          "me@${domain}" = {
            hashedPasswordFile = config.age.secrets.mail.path;
            aliases = ["signup@${domain}" "acme@${domain}" "admin@${domain}"];
          };
          "nextcloud@${domain}".hashedPasswordFile = config.age.secrets.mail.path;
	# "vaultwarden@${domain}".hashedPasswordFile = config.age.secrets.mail.path;
        };
        certificateScheme = "acme-nginx";
      };
    };
}
