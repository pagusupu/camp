{
  config,
  lib,
  ...
}: {
  options.cute.services.seafile = lib.mkEnableOption "";
  config = let
    inherit (config.networking) domain;
  in
    lib.mkIf config.cute.services.seafile {
      services = {
        seafile = {
          enable = false;
          adminEmail = "me@${domain}";
          #initialAdminPassword = "temp";
          ccnetSettings.General.SERVICE_URL = "https://file.${domain}";
        };
        nginx.virtualHosts."file.${domain}" = {
          forceSSL = true;
          enableACME = true;
          #locations."/".proxyPass = "http://127.0.0.1:8082";
        };
      };
    };
}
