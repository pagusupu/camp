{
  config,
  lib,
  ...
}: {
  options.cute.services.misc.grocy = lib.mkEnableOption "";
  config = let
    domain = "grocy.${config.cute.services.web.domain}";
  in
    lib.mkIf config.cute.services.misc.grocy {
      services = {
        grocy = {
          enable = true;
          hostName = "${domain}";
          settings = {
            currency = "NZD";
            calendar.firstDayOfWeek = 1;
          };
        };
        nginx.virtualHosts."${domain}" = {
          forceSSL = true;
          enableACME = true;
        };
      };
    };
}
