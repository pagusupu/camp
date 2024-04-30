{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib) mkEnableOption mkMerge mkIf;
in {
  options.cute.services.web = {
    cinny = mkEnableOption "";
    grocy = mkEnableOption "";
    roundcube = mkEnableOption "";
  };
  config = let
    inherit (config.networking) domain;
    inherit (config.cute.services.web) cinny grocy roundcube;
    common = {
      forceSSL = true;
      enableACME = true;
    };
  in
    mkMerge [
      (mkIf cinny {
        services.nginx.virtualHosts."ciny.${domain}" =
          {root = pkgs.cinny;}
          // common;
      })
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
          nginx.virtualHosts."grcy.${domain}" = {} // common;
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
