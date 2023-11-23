{ 
  config,
  lib,
  ...
}: {
  options.cute.services.nginx = {
    enable = lib.mkEnableOption "";
  };
  config = lib.mkIf config.cute.services.nginx.enable {
    networking.firewall.allowedTCPPorts = [80 443 1313 8080];
    security.acme = {
      acceptTerms = true;
      defaults.email = "amce@pagu.cafe";
    };
    services.nginx = {
      enable = true;
      commonHttpConfig = ''
        real_ip_header CF-Connecting-IP;
        add_header 'Referrer-Policy' 'origin-when-cross-origin';
        add_header X-Frame-Options DENY;
        add_header X-Content-Type-Options nosniff;
      '';
      recommendedProxySettings = true;
      recommendedTlsSettings = true;
      recommendedOptimisation = true;
      recommendedGzipSettings = true;
      virtualHosts = let
        template = {
          forceSSL = true;
          enableACME = true;
        };
      in {
        "jelly.pagu.cafe" =
          template
          // {
            locations."/" = {
              proxyPass = "http://127.0.0.1:8096";
            };
          };
        "komga.pagu.cafe" = 
          template
          // {
            locations."/" = {
              proxyPass = "http://127.0.0.1:8097";
            };
          };
        "tea.pagu.cafe" = 
          template
          // {
            locations."/" = {
              proxyPass = "http://127.0.0.1:8333";
            };
          };
        "vault.pagu.cafe" =
          template
          // {
            locations."/" = {
              proxyPass = "http://127.0.0.1:8222";
              extraConfig = "proxy_pass_header Authorization;";
            };
          };
         ${config.services.nextcloud.hostName} = template // {http2 = true;};
        };
      };
    };
}
