{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.services.backend.nginx = cutelib.mkEnable;
  config = lib.mkIf config.cute.services.backend.nginx (lib.mkMerge [
    {
      services.nginx = {
        enable = true;
        recommendedGzipSettings = true;
        recommendedOptimisation = true;
        recommendedProxySettings = true;
        recommendedTlsSettings = true;
        commonHttpConfig = ''
          real_ip_header CF-Connecting-IP;
          add_header 'Referrer-Policy' 'origin-when-cross-origin';
        '';
        virtualHosts."pagu.cafe" = {
          root = "/storage/cafe";
          locations = {
            "/paguicon".tryFiles = "/paguicon.jpg $uri";
            "/pagupack".tryFiles = "/pagupack.mrpack $uri";
          };
          enableACME = true;
          forceSSL = true;
        };
      };
      networking.firewall.allowedTCPPorts = [80 443];
    }
    {
      security.acme = {
        acceptTerms = true;
        defaults.email = "amce@pagu.cafe";
      };
      users.users.nginx.extraGroups = ["acme"];
    }
  ]);
}
