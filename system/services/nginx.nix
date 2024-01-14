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
      networking.firewall = {
        allowedTCPPorts = [80 443 1313 4533 8080 8448];
        allowedUDPPorts = [80 443 8448];
      };
      security.acme = {
        acceptTerms = true;
        defaults.email = "amce@${domain}";
      };
      services.nginx = {
        enable = true;
        commonHttpConfig = ''
          real_ip_header CF-Connecting-IP;
          add_header 'Referrer-Policy' 'origin-when-cross-origin';
          add_header X-Frame-Options DENY;
          add_header X-Content-Type-Options nosniff;
          add_header Access-Control-Allows-Origin "*";
        '';
        recommendedProxySettings = true;
        recommendedTlsSettings = true;
        recommendedOptimisation = true;
        recommendedGzipSettings = true;
        virtualHosts."${domain}" = {
          forceSSL = true;
          enableACME = true;
          serverAliases = [domain];
          root = "/storage/website/public";
        };
      };
      users.users.nginx.extraGroups = ["acme"];
    };
}
