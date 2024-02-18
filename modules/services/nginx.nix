{
  config,
  lib,
  ...
}: {
  options.cute.services.nginx = {
    enable = lib.mkEnableOption "";
    domain = lib.mkOption {type = lib.types.str;};
  };
  config = let
    domain = "${config.cute.services.nginx.domain}";
  in
    lib.mkIf config.cute.services.nginx.enable {
      networking.firewall.allowedTCPPorts = [80 443 8080];
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
