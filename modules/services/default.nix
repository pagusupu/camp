{
  config,
  lib,
  ...
}: {
  options.cute.services = {
    f2ban = lib.mkEnableOption "";
    grcy = lib.mkEnableOption "";
    jlly = lib.mkEnableOption "";
    kmga = lib.mkEnableOption "";
  };
  config = let
    domain = "${config.cute.services.nginx.domain}";
    inherit (config.cute.services) f2ban grcy jlly kmga;
  in {
    services = {
      fail2ban = lib.mkIf f2ban {
        enable = true;
        bantime-increment = {
          enable = true;
          factor = "16";
        };
      };
      grocy = lib.mkIf grcy {
        enable = true;
        hostName = "grcy.${domain}";
        settings = {
          currency = "NZD";
          calendar.firstDayOfWeek = 1;
        };
      };
      jellyfin = lib.mkIf jlly {
        enable = true;
        openFirewall = true;
      };
      komga = lib.mkIf kmga {
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
        "grcy.${domain}" =
          common
          // {};
        "jlly.${domain}" =
          common
          // {locations."/".proxyPass = "http://127.0.0.1:8096";};
        "kmga.${domain}" =
          common
          // {locations."/".proxyPass = "http://127.0.0.1:8097";};
      };
    };
  };
}
