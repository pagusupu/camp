{
  config,
  lib,
  inputs,
  ...
}: {
  imports = [inputs.nixos-mailserver.nixosModules.default];
  options.cute.services.mailserver = lib.mkEnableOption "";
  config = let
    inherit (config.networking) domain;
  in
    lib.mkIf config.cute.services.mailserver {
      age.secrets.mail = {
        file = ../../misc/secrets/mail.age;
        owner = "dovecot2";
      };
      mailserver = {
        enable = true;
        fqdn = "mail.${domain}";
        domains = [domain];
        loginAccounts = {
          "me@${domain}" = {
            hashedPasswordFile = config.age.secrets.mail.path;
            aliases = ["signup@${domain}" "acme@${domain}" "admin@${domain}"];
          };
          "nextcloud@${domain}".hashedPasswordFile = config.age.secrets.mail.path;
        };
        enableImap = false;
        enableSubmission = false;
        localDnsResolver = false;
      };
    };
}
