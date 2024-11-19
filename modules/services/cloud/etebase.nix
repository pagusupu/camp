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
    services = let
      domain = "sync.${config.networking.domain}";
      unixSocket = "/var/lib/etebase-server/etebase-server.sock";
    in {
      etebase-server = {
        enable = true;
        openFirewall = true;
        dataDir = "/storage/etebase";
        settings = {
          global.secret_file = config.age.secrets.etebase.path;
          allowed_hosts.allowed_host2 = domain; # host1 = 0.0.0.0
        };
        inherit unixSocket;
      };
      nginx.virtualHosts.${domain} = {locations."/".proxyPass = "http://unix:${unixSocket}";} // cutelib.SSL;
    };
  };
}
