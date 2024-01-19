{
  config,
  lib,
  inputs,
  ...
}: {
  imports = [inputs.nixos-mailserver.nixosModules.default];
  options.cute.services.misc.mailserver = lib.mkEnableOption "";
  config = let
    domain = "${config.cute.services.web.domain}";
  in
    lib.mkIf config.cute.services.misc.mailserver {
      age.secrets.mail = {
        file = ../../../secrets/mail.age;
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
