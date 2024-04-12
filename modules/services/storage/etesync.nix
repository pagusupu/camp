{
  config,
  lib,
  ...
}: {
  options.cute.services.storage.etesync = lib.mkEnableOption "";
  config = lib.mkIf config.cute.services.storage.etesync {
    age.secrets.etebase = {
      file = ../../../misc/secrets/etebase.age;
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
