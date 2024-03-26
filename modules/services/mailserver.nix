{
  config,
  lib,
  inputs,
  ...
}: {
  imports = [inputs.nixos-mailserver.nixosModules.default];
  options.cute.services = {
    cube = lib.mkEnableOption "";
    mailserver = lib.mkEnableOption "";
  };
  config = let
    inherit (config.networking) domain;
    inherit (config.cute.services) cube mailserver;
  in {
    age.secrets.mail = lib.mkIf mailserver {
      file = ../../secrets/mail.age;
      owner = "dovecot2";
    };
    mailserver = lib.mkIf mailserver {
      enable = true;
      fqdn = "mail.${domain}";
      domains = ["${domain}"];
      loginAccounts."me@${domain}" = {
        hashedPasswordFile = config.age.secrets.mail.path;
        aliases = ["signup@${domain}" "acme@${domain}" "admin@${domain}"];
      };
      certificateScheme = "acme-nginx";
    };
    services = {
      dovecot2.sieve.extensions = lib.mkIf mailserver ["fileinto"];
      roundcube = lib.mkIf cube {
        enable = true;
        hostName = "cube.${domain}";
        extraConfig = ''
          $config['smtp_server'] = "tls://${config.mailserver.fqdn}";
          $config['smtp_user'] = "%u";
          $config['smtp_pass'] = "%p";
        '';
      };
    };
  };
}
