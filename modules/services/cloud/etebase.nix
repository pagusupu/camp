{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.services.cloud.etebase = cutelib.mkEnable;
  config = lib.mkIf config.cute.services.cloud.etebase {
    assertions = cutelib.assertNginx "etebase";
    age.secrets.etebase = {
      file = ../../../secrets/etebase.age;
      owner = "etebase-server";
    };
    services = rec {
      etebase-server = {
        enable = true;
        openFirewall = true;
        dataDir = "/storage/services/etebase";
        settings = {
          global.secret_file = config.age.secrets.etebase.path;
          allowed_hosts.allowed_host2 = "sync.pagu.cafe"; # host1 = 0.0.0.0
        };
        unixSocket = "/var/lib/etebase-server/etebase-server.sock";
      };
      nginx.virtualHosts."sync.pagu.cafe" = {
        enableACME = true;
        forceSSL = true;
        locations."/".proxyPass = "http://unix:${etebase-server.unixSocket}";
      };
    };
  };
}
