{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.services.etebase = cutelib.mkEnable;
  config = lib.mkIf config.cute.services.etebase {
    age.secrets.etebase = {
      file = ../../secrets/etebase.age;
      owner = "etebase-server";
    };
    services.etebase-server = {
      enable = true;
      openFirewall = true;
      dataDir = "/storage/services/etebase";
      settings = {
        global.secret_file = config.age.secrets.etebase.path;
        allowed_hosts.allowed_host2 = "sync.${config.networking.domain}"; # host1 = 0.0.0.0
      };
      unixSocket = "/var/lib/etebase-server/etebase-server.sock";
    };
  };
}
