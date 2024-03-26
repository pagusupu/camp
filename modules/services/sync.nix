{
  config,
  lib,
  pkgs,
  ...
}: {
  options.cute.services.sync = lib.mkEnableOption "";
  config = lib.mkIf config.cute.services.sync {
    age.secrets.etebase = {
      file = ../../secrets/etebase.age;
      owner = "etebase-server";
    };
    services = {
      etebase-server = {
        enable = true;
        openFirewall = true;
        dataDir = "/storage/services/etebase";
        unixSocket = "/var/lib/etebase-server/etebase-server.sock";
        settings = {
          global.secret_file = config.age.secrets.etebase.path;
          allowed_hosts.allowed_host2 = "sync.${config.networking.domain}"; # host1 = localhost
        };
      };
      nginx.virtualHosts."sync.${config.networking.domain}" = {
        enableACME = true;
        forceSSL = true;
        locations."/".proxyPass = "http://unix:/var/lib/etebase-server/etebase-server.sock";
      };
    };
  };
}
