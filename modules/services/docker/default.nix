{
  config,
  lib,
  ...
}: {
  options.cute.services.docker = {
    enable = lib.mkEnableOption "";
    feishin = lib.mkEnableOption "";
  };
  config = let
    domain = "${config.cute.services.web.domain}";
    inherit (config.cute.services.docker) enable feishin;
  in {
    virtualisation = {
      docker = lib.mkIf enable {
        enable = true;
        storageDriver = "btrfs";
      };
      oci-containers = {
        backend = "docker";
        containers = {
          "feishin" = lib.mkIf feishin {
            image = "ghcr.io/jeffvli/feishin:latest";
            ports = ["9180:9180"];
          }; 
        };
      };
    };
    services.nginx.virtualHosts = {
      "feishin.${domain}" = lib.mkIf feishin {
        forceSSL = true;
        enableACME = true;
        locations."/".proxyPass = "http://127.0.0.1:9180";
      };
    };
  };
}
