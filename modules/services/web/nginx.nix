{
  config,
  lib,
  ...
}: {
  options.cute.services.web = {
    nginx = lib.mkEnableOption "";
    domain = lib.mkOption {type = lib.types.str;};
  };
  config = let
    domain = "${config.cute.services.web.domain}";
  in
    lib.mkIf config.cute.services.web.nginx {
      networking.firewall.allowedTCPPorts = [80 443 1313 8080];
      security.acme = {
        acceptTerms = true;
        defaults.email = "amce@${domain}";
      };
      services.nginx = {
        enable = true;
        commonHttpConfig = ''
          real_ip_header CF-Connecting-IP;
          add_header 'Referrer-Policy' 'origin-when-cross-origin';
        '';
        recommendedProxySettings = true;
        recommendedTlsSettings = true;
        recommendedOptimisation = true;
        recommendedGzipSettings = true;
        virtualHosts."${domain}" = {
          forceSSL = true;
          enableACME = true;
          root = "/storage/website/cafe";
        };
        virtualHosts."dash.${domain}" = {
          forceSSL = true;
          enableACME = true;
          root = "/storage/website/dash";
        };
      };
      users.users.nginx.extraGroups = ["acme"];
    };
}
