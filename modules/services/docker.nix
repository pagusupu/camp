{
  config,
  lib,
  ...
}: {
  options.cute.services.docker = {
    enable = lib.mkEnableOption "";
    fish = lib.mkEnableOption "";
  };
  config = let
    domain = "${config.cute.services.nginx.domain}";
    inherit (config.cute.services.docker) enable fish;
  in {
    virtualisation = lib.mkIf enable {
      docker = {
        enable = true;
        storageDriver = "btrfs";
      };
      oci-containers = {
        backend = "docker";
        containers = {
          "feishin" = lib.mkIf fish {
            image = "ghcr.io/jeffvli/feishin:latest";
            ports = ["9180:9180"];
          };
        };
      };
    };
    services.nginx.virtualHosts = {
      "fish.${domain}" = lib.mkIf fish {
        forceSSL = true;
        enableACME = true;
        locations."/".proxyPass = "http://127.0.0.1:9180";
      };
    };
  };
}
