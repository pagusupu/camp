{
  config,
  lib,
  ...
}: {
  options.cute.services.nginx = lib.mkEnableOption "";
  config = let
    inherit (config.networking) domain;
  in
    lib.mkIf config.cute.services.nginx {
      networking.firewall.allowedTCPPorts = [80 443];
      security.acme = {
        acceptTerms = true;
        defaults.email = "amce@${domain}";
      };
      services.nginx = {
        enable = true;
        recommendedProxySettings = true;
        recommendedTlsSettings = true;
        recommendedOptimisation = true;
        recommendedGzipSettings = true;
        commonHttpConfig = ''
          real_ip_header CF-Connecting-IP;
          add_header 'Referrer-Policy' 'origin-when-cross-origin';
        '';
        virtualHosts = {
          "${domain}" = {
            forceSSL = true;
            enableACME = true;
            root = "/storage/website/cafe";
          };
          "dash.${domain}" = {
            forceSSL = true;
            enableACME = true;
            root = "/storage/website/dash";
          };
          "next.${domain}" = {
            forceSSL = true;
            enableACME = true;
            root = "/storage/website/error";
          };
        };
      };
      users.users.nginx.extraGroups = ["acme"];
    };
}
