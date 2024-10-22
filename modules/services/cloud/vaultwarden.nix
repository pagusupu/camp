{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.services.cloud.vaultwarden = cutelib.mkEnable;
  config = lib.mkIf config.cute.services.cloud.vaultwarden {
    assertions = cutelib.assertNginx "vaultwarden";
    services = {
      vaultwarden = {
        enable = true;
        config = {
          DOMAIN = "https://wrdn.pagu.cafe";
          ROCKET_PORT = 8222;
          SIGNUPS_ALLOWED = false;
        };
        backupDir = "/storage/services/vaultwarden";
      };
      nginx.virtualHosts."wrdn.pagu.cafe" = {
        locations."/" = {
          proxyPass = "http://localhost:8222";
          extraConfig = "proxy_pass_header Authorization;";
        };
        enableACME = true;
        forceSSL = true;
      };
    };
  };
}
