{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.services.media.freshrss = cutelib.mkEnable;
  config = lib.mkIf config.cute.services.media.freshrss {
    assertions = cutelib.assertNginx "freshrss";
    age.secrets.freshrss = {
      file = ../../../secrets/freshrss.age;
      owner = "freshrss";
    };
    services = {
      freshrss = {
        enable = true;
        baseUrl = "https://frss.pagu.cafe";
        dataDir = "/storage/services/freshrss";
        defaultUser = "pagu";
        passwordFile = config.age.secrets.freshrss.path;
        virtualHost = "frss.pagu.cafe";
      };
      nginx.virtualHosts."frss.pagu.cafe" = {
        enableACME = true;
        forceSSL = true;
      };
    };
  };
}
