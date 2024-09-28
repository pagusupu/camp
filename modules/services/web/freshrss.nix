{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.services.web.freshrss = cutelib.mkWebOpt "frss" 0;
  config = let
    inherit (config.cute.services.web.freshrss) enable dns;
    domain = "${dns}.${config.networking.domain}";
  in
    lib.mkIf enable {
      assertions = cutelib.assertNginx "freshrss";
      age.secrets.freshrss = {
        file = ../../../secrets/freshrss.age;
        owner = "freshrss";
      };
      services = {
        freshrss = {
          inherit enable;
          baseUrl = "https://${domain}";
          dataDir = "/storage/services/freshrss";
          defaultUser = "pagu";
          passwordFile = config.age.secrets.freshrss.path;
          virtualHost = domain;
        };
        nginx.virtualHosts."${domain}" = {
          enableACME = true;
          forceSSL = true;
        };
      };
    };
}
