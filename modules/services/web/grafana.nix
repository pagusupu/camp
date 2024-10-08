{
  config,
  lib,
  cutelib,
  ...
}: {
  options.cute.services.web.grafana = cutelib.mkWebOpt "view" 8090;
  config = let
    inherit (config.cute.services.web.grafana) enable port;
  in
    lib.mkIf enable {
      services = {
        grafana = {
          enable = true;
          settings.server = {
            http_addr = "0.0.0.0";
            http_port = port;
            enable_gzip = true;
          };
        };
        prometheus = {
          enable = true;
          port = 8080;
          exporters = {
            node = {
              enable = true;
              enabledCollectors = ["systemd"];
            };
          };
          scrapeConfigs = [
            {
              job_name = "aoi";
              static_configs = [{targets = ["127.0.0.1:9100"];}];
            }
            {
              job_name = "blocky";
              static_configs = [{targets = ["192.168.178.82:4000"];}];
            }
            {
              job_name = "navidrome";
              static_configs = [{targets = ["127.0.0.1:8098"];}];
            }
          ];
        };
      };
      cute.services.servers.nginx.hosts = ["grafana"];
    };
}
