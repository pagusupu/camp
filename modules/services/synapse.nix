{
  config,
  lib,
  _lib,
  pkgs,
  ...
}: {
  options.cute.services.synapse = lib.mkEnableOption "";
  config = lib.mkIf config.cute.services.synapse {
    assertions = _lib.assertNginx "synapse";
    age.secrets.synapse = {
      file = ../../misc/secrets/synapse.age;
      owner = "matrix-synapse";
    };
    services = {
      matrix-synapse = {
        enable = true;
        settings = {
          max_upload_size = "10G";
          registration_requires_token = true;
          registration_shared_secret_path = config.age.secrets.synapse.path;
          server_name = config.networking.domain;
          url_preview_enabled = true;
          withJemalloc = true;
          listeners = [
            {
              port = 8008;
              bind_addresses = ["0.0.0.0"];
              type = "http";
              tls = false;
              x_forwarded = true;
              resources = [
                {
                  names = ["client"];
                  compress = true;
                }
                {
                  names = ["federation"];
                  compress = false;
                }
              ];
            }
          ];
        };
      };
      postgresql = {
        enable = true;
        initialScript = pkgs.writeText "synapse-init.sql" ''
          CREATE DATABASE "matrix-synapse" WITH OWNER "matrix-synapse"
          TEMPLATE template0
          LC_COLLATE = "C"
          LC_CTYPE = "C";
        '';
      };
    };
  };
}
