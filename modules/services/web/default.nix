{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkMerge mkIf;
in {
  options.cute.services.web = {
    roundcube = mkEnableOption "";
    grocy = mkEnableOption "";
  };
  config = let
    inherit (config.networking) domain;
    inherit (config.cute.services.web) roundcube grocy;
  in
    mkMerge [
      (mkIf grocy {
        services = {
          grocy = {
            enable = true;
            hostName = "grcy.${domain}";
            settings = {
              currency = "NZD";
              calendar.firstDayOfWeek = 1;
            };
          };
          nginx.virtualHosts."grcy.${domain}" = {
            forceSSL = true;
            enableACME = true;
          };
        };
      })
      (mkIf roundcube {
        services.roundcube = {
          enable = true;
          hostName = "cube.${domain}";
          extraConfig = ''
            $config['smtp_server']  = "tls://mail.${domain}";
            $config['smtp_user'] = "%u";
            $config['smtp_pass'] = "%p";
          '';
        };
      })
    ];
}
