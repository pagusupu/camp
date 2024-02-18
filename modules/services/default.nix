{
  config,
  lib,
  ...
}: {
  options.cute.services = {
    f2ban = lib.mkEnableOption "";
    grocy = lib.mkEnableOption "";
    jelly = lib.mkEnableOption "";
    komga = lib.mkEnableOption "";
  };
  config = let
    domain = "${config.cute.services.nginx.domain}";
    inherit (config.cute.services) f2ban grocy jelly komga;
  in {
    services = {
      fail2ban = lib.mkIf f2ban {
        enable = true;
        bantime-increment = {
          enable = true;
          factor = "16";
        };
      };
      grocy = lib.mkIf grocy {
        enable = true;
        hostName = "grocy.${domain}";
        settings = {
          currency = "NZD";
          calendar.firstDayOfWeek = 1;
        };
      };
      jellyfin = lib.mkIf jelly {
        enable = true;
        openFirewall = true;
      };
      komga = lib.mkIf komga {
        enable = true;
        openFirewall = true;
        port = 8097;
      };
      nginx.virtualHosts = let
        common = {
          forceSSL = true;
          enableACME = true;
        };
      in {
        "grocy.${domain}" =
          common
          // {};
        "jelly.${domain}" =
          common
          // {locations."/".proxyPass = "http://127.0.0.1:8096";};
        "komga.${domain}" =
          common
          // {locations."/".proxyPass = "http://127.0.0.1:8097";};
      };
    };
  };
}
