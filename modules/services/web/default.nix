{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkMerge mkIf;
in {
  options.cute.services.web = {
    cube = mkEnableOption "";
    grcy = mkEnableOption "";
  };
  config = let
    inherit (config.networking) domain;
    inherit (config.cute.services.web) cube grcy;
  in
    mkMerge [
      (mkIf grcy {
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
      (mkIf cube {
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
