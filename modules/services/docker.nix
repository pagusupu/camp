{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption mkMerge mkIf;
in {
  options.cute.services.docker = {
    enable = mkEnableOption "";
    feishin = mkEnableOption "";
    linkding = mkEnableOption "";
    memos = mkEnableOption "";
  };
  config = let
    inherit (config.networking) domain;
    inherit (config.cute.services.docker) enable feishin linkding memos;
    c = {
      forceSSL = true;
      enableACME = true;
    };
    i = "http://127.0.0.1:";
    assertions = [
      {
        assertion = config.cute.services.docker.enable;
        message = "requires docker service.";
      }
      {
        assertion = config.cute.services.web.nginx;
        message = "requires nginx service.";
      }
    ];
  in
    mkMerge [
      (mkIf enable {
        virtualisation = {
          docker = {
            enable = true;
            storageDriver = "btrfs";
          };
          oci-containers.backend = "docker";
        };
      })
      (mkIf feishin {
        virtualisation.oci-containers.containers."feishin" = {
          image = "ghcr.io/jeffvli/feishin:latest";
          ports = ["9180:9180"];
        };
        services.nginx.virtualHosts."fish.${domain}" = {locations."/".proxyPass = i + "9180";} // c;
        inherit assertions;
      })
      (mkIf linkding {
        age.secrets.linkding.file = ../../misc/secrets/linkding.age;
        virtualisation.oci-containers.containers."linkding" = {
          image = "sissbruecker/linkding:latest";
          ports = ["9090:9090"];
          volumes = ["/storage/services/linkding/:/etc/linkding/data"];
          environmentFiles = [config.age.secrets.linkding.path];
        };
        services.nginx.virtualHosts."link.${domain}" = {locations."/".proxyPass = i + "9090";} // c;
        inherit assertions;
      })
      (mkIf memos {
        virtualisation.oci-containers.containers."memos" = {
          image = "neosmemo/memos:stable";
          ports = ["5230:5230"];
          volumes = ["/storage/services/memos/:/var/opt/memos"];
        };
        services.nginx.virtualHosts."memo.${domain}" = {locations."/".proxyPass = i + "5230";} // c;
        inherit assertions;
      })
    ];
}
