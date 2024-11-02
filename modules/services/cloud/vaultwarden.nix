{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.services.cloud.vaultwarden = cutelib.mkEnable;
  config = lib.mkIf config.cute.services.cloud.vaultwarden {
    assertions = cutelib.assertNginx "vaultwarden";
    services = let
      port = 8222;
    in {
      vaultwarden = {
        enable = true;
        config = {
          DOMAIN = "https://wrdn.pagu.cafe";
          ROCKET_PORT = port;
          SIGNUPS_ALLOWED = false;
        };
        backupDir = "/storage/services/vaultwarden";
      };
      nginx = cutelib.host "wrdn" port "" "proxy_pass_header Authorization;";
    };
  };
}
