{
  config,
  lib,
  ...
}: {
  options.cute.services.docker = {
    enable = lib.mkEnableOption "";
    feishin = lib.mkEnableOption "";
    watcharr = lib.mkEnableOption "";
  };
  config = let
    domain = "${config.cute.services.web.domain}";
    inherit (config.cute.services.docker) enable feishin watcharr;
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
	  "watcharr" = lib.mkIf watcharr {
	    image = "ghcr.io/sbondco/watcharr:latest";
	    ports = ["3080:3080"];
	    volumes = ["./container_data:/data"];
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
      "watcharr.${domain}" = lib.mkIf watcharr {
	forceSSL = true;
	enableACME = true;
	locations."/".proxyPass = "http://127.0.0.1:3080";
      };
    };
  };
}
