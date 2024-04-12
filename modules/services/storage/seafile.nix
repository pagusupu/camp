{
  config,
  lib,
  ...
}: {
  options.cute.services.storage.seafile = lib.mkEnableOption "";
  config = let
    inherit (config.networking) domain;
  in
    lib.mkIf config.cute.services.storage.seafile {
      services = {
        seafile = {
          enable = true;
          adminEmail = "me@${domain}";
          #initialAdminPassword = "temp";
          ccnetSettings.General.SERVICE_URL = "https://file.${domain}";
        };
        nginx.virtualHosts."file.${domain}" = {
          forceSSL = true;
          enableACME = true;
          locations = {
            "/" = {
              proxyPass = "http://127.0.0.1:8000";
            };
            "/seafhttp" = {
              proxyPass = "http://127.0.0.1:8082";
            };
          };
        };
      };
    };
}
